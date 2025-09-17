import 'package:flutter/material.dart';

class OfflineDialog extends StatelessWidget {
  final VoidCallback onRetry;

  const OfflineDialog({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // 뒤로가기 금지 (강제 연결 유도)
      onWillPop: () async => false,
      child: AlertDialog(
        title: const Text('네트워크 연결 필요'),
        content: const Text('인터넷에 연결된 후 다시 시도해 주세요.'),
        actions: [
          TextButton(
            onPressed: onRetry, // 즉시 재검증
            child: const Text('다시 시도'),
          ),
        ],
      ),
    );
  }
}
