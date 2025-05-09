import 'package:flutter/material.dart';
import 'package:site_inspection_checklist_app/core/constants.dart';

abstract class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: kPrimaryColor,
        scaffoldBackgroundColor: kScaffoldBackgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          foregroundColor: Colors.black,
          shadowColor: Colors.black12,
          elevation: 8,
          scrolledUnderElevation: 8,
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          actionsPadding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
        ),
      );
}
