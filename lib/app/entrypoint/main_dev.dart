import 'package:doit_doit/app/util/app_log.dart';
import '../environment/flavors.dart';

void main() async {
  AppLog.i('dev 모드로 실행');

  F.runFlavoredApp(flavor: Flavor.dev);
}
