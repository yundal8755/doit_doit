import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'network_service.dart';
import 'network_status.dart';

final networkServiceProvider = Provider<NetworkService>((ref) {
  final service = NetworkService();
  ref.onDispose(service.dispose);
// 앱 시작 시 한 번 초기화
// (주의) 위젯 트리에서 첫 구독 전에 init을 보장하려면 main에서 미리 read하여 init 호출
  service.init();
  return service;
});

final networkStatusStreamProvider = StreamProvider<NetworkStatus>((ref) {
  final service = ref.watch(networkServiceProvider);
  return service.status$;
});

/// 액션 전 네트워크 보장 helper
Future<bool> ensureOnline(WidgetRef ref) async {
  final service = ref.read(networkServiceProvider);
  await service.checkNow();
  final status = await ref.read(networkStatusStreamProvider.future);
  return status.isOnline;
}
