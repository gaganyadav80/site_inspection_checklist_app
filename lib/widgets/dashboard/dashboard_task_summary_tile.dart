import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:site_inspection_checklist_app/core/constants.dart';
import 'package:site_inspection_checklist_app/core/enums.dart';
import 'package:site_inspection_checklist_app/providers/inspection_task_notifier.dart';

class DashboardTaskSummaryTile extends ConsumerWidget {
  const DashboardTaskSummaryTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allTasksState = ref.watch(
      inspectionTaskNotifier.select(
        (state) => state.tasksState,
      ),
    );

    int completedTasksCount = 0;
    int failedTasksCount = 0;
    int notApplicableTasksCount = 0;
    int pendingTasksCount = 0;

    if (allTasksState.valueOrNull != null) {
      for (final task in allTasksState.valueOrNull!) {
        final status = TaskStatus.fromId(task.status.id);
        switch (status) {
          case TaskStatus.passed:
            completedTasksCount++;
          case TaskStatus.failed:
            failedTasksCount++;
          case TaskStatus.notApplicable:
            notApplicableTasksCount++;
          case TaskStatus.pending:
            pendingTasksCount++;
        }
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: kScaffoldBackgroundColor,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              completedTasksCount == 0
                  ? 'You have $pendingTasksCount pending tasks'
                  : '$completedTasksCount/12 Complete',
              style: TextTheme.of(context).bodySmall,
            ),
          ),
          Row(
            spacing: 8,
            children: List.generate(
              3,
              (index) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: [
                        kPassedItemColor,
                        kFailedItemColor,
                        kNotApplicableItemColor,
                      ][index],
                    ),
                    SizedBox(width: 4),
                    Text(
                      [
                        completedTasksCount,
                        failedTasksCount,
                        notApplicableTasksCount,
                      ][index]
                          .toString(),
                      style: TextTheme.of(context).bodySmall,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
