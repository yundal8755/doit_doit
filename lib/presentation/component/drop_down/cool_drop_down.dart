import 'package:flutter/material.dart';

/// 사용 예:
/// showCustomDropdown<String>(
///   context: context,
///   anchorKey: myButtonKey,
///   items: ['Apple', 'Banana', 'Cherry', 'Durian'],
///   onItemSelected: (value) {
///     // 아이템 선택 시 로직
///   },
/// );
///
/// 위처럼 호출하면 anchorKey로 지정한 위젯 아래에 드롭다운이 표시됨.
void showCustomDropdown<T>({
  required BuildContext context,
  required GlobalKey anchorKey,
  required List<T> items,
  required ValueChanged<T> onItemSelected,
}) {
  /// (1) anchorKey로부터 RenderBox를 얻어서, 위젯의 전역 좌표(Offset)와 크기(Size) 구하기
  final renderBox = anchorKey.currentContext!.findRenderObject() as RenderBox;
  final size = renderBox.size; // anchor 위젯의 크기
  final offset = renderBox.localToGlobal(Offset.zero); // 화면 내 위치

  /// (2) 오버레이 위젯(OverlayEntry)을 생성
  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) {
      // Dropdown을 표시할 위치: offset.dy + size.height(위젯 아래) + 8px
      final dx = offset.dx;
      final dy = offset.dy + size.height + 8;

      return Stack(
        children: [
          // (A) Dropdown 바깥을 탭하면 닫히도록 투명 배경 처리
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => overlayEntry.remove(),
              child: const SizedBox.expand(),
            ),
          ),

          // (B) 실제 Dropdown
          Positioned(
            left: dx,
            top: dy,
            width: size.width, // anchor 위젯과 동일한 폭
            child: Material(
              color: Colors.white,
              elevation: 4.0,
              borderRadius: BorderRadius.circular(8),
              child: ConstrainedBox(
                // (항상 스크롤되길 원하므로 maxHeight 지정)
                constraints: const BoxConstraints(
                  maxHeight: 200, // 필요 시 늘이거나 줄일 수 있음
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return InkWell(
                      onTap: () {
                        onItemSelected(item);
                        overlayEntry.remove();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          item.toString(),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      );
    },
  );

  /// (3) Overlay에 삽입
  Overlay.of(context).insert(overlayEntry);
}
