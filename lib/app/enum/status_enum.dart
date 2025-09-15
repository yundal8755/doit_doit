///
/// Status 열거형
///
enum Status {
  ongoing(value: '진행 중'),
  completed(value: '완료');

  final String value;

  const Status({required this.value});
}
