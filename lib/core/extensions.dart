import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  double get bottomSafePadding {
    final bottomPadding = MediaQuery.viewPaddingOf(this).bottom;
    return bottomPadding == 0 ? 16 : bottomPadding;
  }

  double get bottomKeyboardPadding => MediaQuery.viewInsetsOf(this).bottom;

  double get screenWidth => MediaQuery.sizeOf(this).width;

  TextTheme get textTheme => Theme.of(this).textTheme;
}
