import 'package:flutter/material.dart';
import 'package:site_inspection_checklist_app/core/constants.dart';
import 'package:site_inspection_checklist_app/model/item_status.dart';

class UiHelper {
  static MaterialColor? getStatusColor(ItemStatus status) {
    switch (status.id) {
      case 1:
        return kPassedItemColor;
      case 2:
        return kFailedItemColor;
      case 3:
        return kNotApplicableItemColor;
      default:
        return null;
    }
  }

  static Widget getStatusIcon(ItemStatus status) {
    switch (status.id) {
      case 1:
        return Icon(Icons.check);
      case 2:
        return Icon(Icons.close);
      case 3:
        return Icon(Icons.block);
      default:
        return SizedBox();
    }
  }
}
