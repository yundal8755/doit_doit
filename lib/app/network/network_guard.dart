import 'dart:io' show Platform;
import 'dart:io' as io show exit;
import 'package:flutter/services.dart';
import 'package:doit_doit/presentation/widget/component/alert_dialog/cool_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'network_providers.dart';
import 'network_status.dart';
import 'package:doit_doit/app/router/router.dart' show rootNavigatorKey;

class NetworkGuard extends ConsumerStatefulWidget {
  final Widget child;
  const NetworkGuard({super.key, required this.child});

  @override
  ConsumerState<NetworkGuard> createState() => _NetworkGuardState();
}

class _NetworkGuardState extends ConsumerState<NetworkGuard> {
  bool _dialogShown = false;

  /// 네비게이터 컨텍스트가 준비될 때까지 대기
  Future<BuildContext?> _waitForRootContext({int tries = 6}) async {
    for (var i = 0; i < tries; i++) {
      await SchedulerBinding.instance.endOfFrame;
      final ctx = rootNavigatorKey.currentContext;
      if (ctx != null) return ctx;
      await Future.delayed(const Duration(milliseconds: 16));
    }
    return null;
  }

  /// 플랫폼별 안전 종료
  Future<void> safeExitApp() async {
    // 1) 다이얼로그 닫기 시도
    final nav = rootNavigatorKey.currentState;
    if (nav?.canPop() ?? false) {
      nav!.pop();
    }

    // 2) 플랫폼별 종료 처리
    if (Platform.isAndroid) {
      await SystemNavigator.pop();
    } else if (Platform.isIOS) {
      io.exit(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<NetworkStatus>>(networkStatusStreamProvider,
        (prev, next) async {
      next.whenData((status) async {
        if (status.isOffline && !_dialogShown && mounted) {
          _dialogShown = true;

          final ctx = await _waitForRootContext();
          if (!mounted || ctx == null) {
            _dialogShown = false;
            return;
          }

          await showDialog(
            context: ctx,
            useRootNavigator: true,
            barrierDismissible: false,
            builder: (_) {
              // 다이얼로그 내부 상태 관리
              String subtitle = "인터넷에 연결된 후 다시 시도해 주세요.";
              bool loading = false;

              Future<void> handleRetry(StateSetter setState) async {
                if (!mounted) return;
                setState(() => loading = true);

                // 즉시 재검증
                await ref.read(networkServiceProvider).checkNow();
                final result =
                    await ref.read(networkStatusStreamProvider.future);

                setState(() => loading = false);

                if (result.isOnline) {
                  // 온라인 전환: 다이얼로그 닫기
                  final nav = rootNavigatorKey.currentState;
                  if (nav?.canPop() ?? false) nav!.pop();
                } else {
                  // 여전히 오프라인: 문구 업데이트
                  setState(() {
                    subtitle = "아직 연결되지 않았어요. 네트워크를 확인한 뒤 다시 시도해 주세요.";
                  });
                }
              }

              return StatefulBuilder(
                builder: (dialogCtx, setState) {
                  return CoolAlertDialog.dividedBtn(
                    title: "네트워크 연결 필요",
                    subTitle: loading ? "연결 상태 확인 중..." : subtitle,
                    leftBtnContent: "종료",
                    rightBtnContent: "다시 시도",
                    onLeftBtnClicked: () async {
                      await safeExitApp();
                    },
                    onRightBtnClicked: () async {
                      await handleRetry(setState);
                    },
                  );
                },
              );
            },
          );

          _dialogShown = false;
        }

        if (status.isOnline && _dialogShown && mounted) {
          final nav = rootNavigatorKey.currentState;
          if (nav?.canPop() ?? false) {
            nav!.pop();
          }
        }
      });
    });

    return widget.child;
  }
}
