// Place fonts/CustomIcons.ttf in your fonts/ directory and
// add the following to your pubspec.yaml
// flutter:
//   fonts:
//    - family: CustomIcons
//      fonts:
//       - asset: fonts/CustomIcons.ttf
import 'package:flutter/widgets.dart';

class CustomIcons {
  CustomIcons._();

  static const String _fontFamily = 'CustomIcons';

  static const IconData sheet = IconData(0xe956, fontFamily: _fontFamily);
  static const IconData scissors = IconData(0xe957, fontFamily: _fontFamily);
  static const IconData detail = IconData(0xe958, fontFamily: _fontFamily);
}
