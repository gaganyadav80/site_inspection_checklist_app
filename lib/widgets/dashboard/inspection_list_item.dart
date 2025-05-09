import 'package:flutter/material.dart';
import 'package:site_inspection_checklist_app/core/constants.dart';
import 'package:site_inspection_checklist_app/core/extensions.dart';
import 'package:site_inspection_checklist_app/core/ui_helper.dart';
import 'package:site_inspection_checklist_app/model/inspection_task.dart';
import 'package:site_inspection_checklist_app/widgets/inspection_item_status_icon.dart';
import 'package:site_inspection_checklist_app/widgets/update_item_status_modal_sheet.dart';

class InspectionListItem extends StatelessWidget {
  const InspectionListItem({
    super.key,
    required this.item,
  });

  final InspectionTask item;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = UiHelper.getStatusColor(item.status);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return UpdateItemStatusModalSheet(item: item);
          },
        );
      },
      child: Material(
        color: Colors.white,
        borderRadius: kDefaultBorderRadius,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:
                backgroundColor?.shade50.withValues(alpha: 0.8) ?? Colors.white,
            borderRadius: kDefaultBorderRadius,
            border: Border.all(
              color: backgroundColor?.shade200 ?? Colors.grey.shade200,
            ),
            boxShadow: kLightBoxShadow,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      item.category.name,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              InspectionItemStatusIcon(
                status: item.status,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
