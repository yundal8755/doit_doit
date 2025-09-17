import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'network_status.dart';

/// OS 레벨 연결 상태 + 실제 인터넷 연결 유무를 결합해 최종 상태를 산출한다.
/// - Wi‑Fi/셀룰러 연결이라도 captive portal 등으로 인터넷 미접속일 수 있으므로
/// 반드시 [InternetConnectionCheckerPlus]로 실제 접근 가능 여부를 확인.
class NetworkService {
  final Connectivity _connectivity;
  final InternetConnection _internetChecker;

  final _statusController = StreamController<NetworkStatus>.broadcast();
  StreamSubscription<List<ConnectivityResult>>? _connSub;
  bool _disposed = false;

  NetworkService({
    Connectivity? connectivity,
    InternetConnection? internetChecker,
  })  : _connectivity = connectivity ?? Connectivity(),
        _internetChecker = internetChecker ?? InternetConnection();

  /// 외부에서 구독해서 UI를 갱신하거나 Dialog를 띄울 때 사용
  Stream<NetworkStatus> get status$ => _statusController.stream;

  /// 초기화: 현재 상태 계산 + 변경 스트림 구독
  Future<void> init() async {
// 최초 상태 계산
    await _recompute();

// 이후 변경 사항 반영
    _connSub = _connectivity.onConnectivityChanged.listen((_) async {
      await _recompute();
    });
  }

  /// 사용자가 "다시 시도"를 눌렀을 때 즉시 재검증
  Future<void> checkNow() async => _recompute();

  Future<void> _recompute() async {
    if (_disposed) return;
    final results = await _connectivity.checkConnectivity();
    if (results.isEmpty || results.every((r) => r == ConnectivityResult.none)) {
      _statusController.add(NetworkStatus.offline);
      return;
    }
// 실제 인터넷 접근 가능 여부 체크
    final ok = await _internetChecker.hasInternetAccess;
    _statusController.add(ok ? NetworkStatus.online : NetworkStatus.offline);
  }

  Future<void> dispose() async {
    _disposed = true;
    await _connSub?.cancel();
    await _statusController.close();
  }
}
