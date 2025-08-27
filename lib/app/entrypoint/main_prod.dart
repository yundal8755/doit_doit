import 'package:flutter/material.dart';
import '../environment/app.dart';
import '../environment/flavors.dart';

Future<void> main() async {
  F.init();
  F.appFlavor = Flavor.prod;

  runApp(const App());
}
