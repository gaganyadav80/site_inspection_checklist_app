import 'package:flutter/material.dart';
import 'package:site_inspection_checklist_app/core/ui_helper.dart';
import 'package:site_inspection_checklist_app/model/item_status.dart';

class InspectionItemStatusIcon extends StatelessWidget {
  const InspectionItemStatusIcon({
    super.key,
    required this.status,
  });

  final ItemStatus status;

  @override
  Widget build(BuildContext context) {
    final color = UiHelper.getStatusColor(status);
    final icon = UiHelper.getStatusIcon(status);

    return Container(
      width: 20,
      height: 20,
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(
          width: 2,
          color: color ?? Colors.grey.shade300,
        ),
      ),
      child: Center(
        child: FittedBox(
          child: IconTheme(
            data: IconThemeData(
              color: Colors.white,
            ),
            child: icon,
          ),
        ),
      ),
    );
  }
}
