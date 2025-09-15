///
/// 우선순위(Priority) 열거형
///
enum Priority {
  urgent(value: '긴급'),
  important(value: '중요'),
  normal(value: '보통'),
  low(value: '낮음');

  final String value;

  const Priority({required this.value});
}
