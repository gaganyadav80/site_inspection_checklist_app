import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFF3176FF);
final Color kScaffoldBackgroundColor = Colors.grey.shade50;

const MaterialColor kPassedItemColor = Colors.green;
const MaterialColor kFailedItemColor = Colors.red;
const MaterialColor kNotApplicableItemColor = Colors.grey;

final BorderRadius kDefaultBorderRadius = BorderRadius.circular(8);
final List<BoxShadow> kLightBoxShadow = <BoxShadow>[
  BoxShadow(
    color: Color.fromRGBO(16, 24, 40, 0.04),
    offset: Offset(0, 1),
    blurRadius: 2,
  ),
];
