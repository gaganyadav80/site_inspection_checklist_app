import 'package:flutter/material.dart';
import 'package:site_inspection_checklist_app/core/constants.dart';

class UiHelper {
  static MaterialColor? getStatusColor(String status) {
    switch (status) {
      case 'passed':
        return kPassedItemColor;
      case 'failed':
        return kFailedItemColor;
      case 'not_applicable':
        return kNotApplicableItemColor;
      default:
        return null;
    }
  }

  static Widget getStatusIcon(String status) {
    switch (status) {
      case 'passed':
        return Icon(Icons.check);
      case 'failed':
        return Icon(Icons.close);
      case 'not_applicable':
        return Icon(Icons.block);
      default:
        return SizedBox();
    }
  }
}
