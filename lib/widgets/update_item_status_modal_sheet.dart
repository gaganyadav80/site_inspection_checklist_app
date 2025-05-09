import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:site_inspection_checklist_app/core/constants.dart';
import 'package:site_inspection_checklist_app/core/enums.dart';
import 'package:site_inspection_checklist_app/core/extensions.dart';
import 'package:site_inspection_checklist_app/core/ui_helper.dart';
import 'package:site_inspection_checklist_app/model/inspection_task.dart';
import 'package:site_inspection_checklist_app/providers/generic_providers.dart';
import 'package:site_inspection_checklist_app/providers/inspection_task_notifier.dart';
import 'package:site_inspection_checklist_app/widgets/secondary_button.dart';

class UpdateItemStatusModalSheet extends ConsumerWidget {
  const UpdateItemStatusModalSheet({
    super.key,
    required this.item,
  });

  final InspectionTask item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusOptionsList =
        ref.watch(statusProvider).valueOrNull?.toList() ?? [];

    statusOptionsList.removeWhere(
      (element) => element.id == TaskStatus.pending.id,
    );

    return SingleChildScrollView(
      padding: EdgeInsets.all(16).copyWith(
        bottom: context.bottomSafePadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: Text(
                  'Update Status',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.titleMedium,
                ),
              ),
              CloseButton(
                color: Colors.grey.shade600,
              ),
            ],
          ),
          Divider(
            height: 24,
            thickness: 1,
            color: Colors.grey.shade200,
          ),
          SizedBox(height: 8),
          Text(
            item.name,
            style: context.textTheme.bodyLarge?.copyWith(
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: 4),
          Text(
            item.category.name,
            style: context.textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 16),
          ...List.generate(
            statusOptionsList.length,
            (index) {
              final status = statusOptionsList[index];
              final statusColor = UiHelper.getStatusColor(status.id);
              final statusIcon = UiHelper.getStatusIcon(status.id);

              return Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: FilledButton(
                  onPressed: () {
                    ref.read(inspectionTaskNotifier.notifier).updateTaskStatus(
                          item.id,
                          status,
                        );
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      statusColor?.shade50.withValues(alpha: 0.8) ??
                          Colors.white,
                    ),
                    foregroundColor:
                        WidgetStateProperty.all(statusColor?.shade700),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        side: BorderSide(
                          color: statusColor?.shade200 ?? Colors.grey.shade200,
                        ),
                        borderRadius: kDefaultBorderRadius,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                            color: statusColor ?? Colors.grey.shade300,
                          ),
                        ),
                        child: Center(
                          child: FittedBox(
                            child: statusIcon,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        status.name,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 16),
          Divider(
            height: 24,
            thickness: 1,
            color: Colors.grey.shade200,
          ),
          SecondaryButton(
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Cancel'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
