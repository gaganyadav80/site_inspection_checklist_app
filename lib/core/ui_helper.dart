import 'package:flutter/material.dart';
import 'package:site_inspection_checklist_app/core/constants.dart';
import 'package:site_inspection_checklist_app/core/enums.dart';

class UiHelper {
  static MaterialColor? getStatusColor(int statusId) {
    final status = TaskStatus.fromId(statusId);
    switch (status) {
      case TaskStatus.passed:
        return kPassedItemColor;
      case TaskStatus.failed:
        return kFailedItemColor;
      case TaskStatus.notApplicable:
        return kNotApplicableItemColor;
      default:
        return null;
    }
  }

  static Widget getStatusIcon(int statusId) {
    final status = TaskStatus.fromId(statusId);
    switch (status) {
      case TaskStatus.passed:
        return Icon(Icons.check);
      case TaskStatus.failed:
        return Icon(Icons.close);
      case TaskStatus.notApplicable:
        return Icon(Icons.block);
      default:
        return SizedBox();
    }
  }
}
