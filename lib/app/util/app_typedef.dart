import 'package:doit_doit/feature/todo/entity/todo_entity.dart';

/// 레코드 타입 별칭
typedef TodoBuckets = ({
  List<TodoEntity?> ongoing,
  List<TodoEntity?> completed
});
