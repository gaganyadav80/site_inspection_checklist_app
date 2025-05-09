import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:site_inspection_checklist_app/core/constants.dart';
import 'package:site_inspection_checklist_app/core/extensions.dart';
import 'package:site_inspection_checklist_app/providers/inspection_task_notifier.dart';
import 'package:site_inspection_checklist_app/widgets/dashboard/inspection_list_item.dart';

class InspectionListBuilder extends ConsumerWidget {
  const InspectionListBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksState = ref.watch(
      inspectionTaskNotifier.select(
        (state) => state.tasksState,
      ),
    );

    return tasksState.when(
      loading: () {
        return const Center(
          child: CircularProgressIndicator(
            strokeCap: StrokeCap.round,
            color: kPrimaryColor,
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      },
      data: (tasksList) {
        if (tasksList.isEmpty) {
          return Padding(
            padding: EdgeInsets.only(
              top: 100,
              left: 24,
              right: 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.checklist,
                  size: 64,
                ),
                SizedBox(height: 8),
                Text(
                  'You haven\'t added any tasks yet',
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleLarge,
                ),
                SizedBox(height: 12),
                Text(
                  'All your important task related to site inspections will be listed here. Add a new task to get started.',
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          );
        }
        return ListView.separated(
          itemCount: tasksList.length,
          padding: EdgeInsets.all(16).copyWith(
            bottom: context.bottomSafePadding,
          ),
          separatorBuilder: (context, index) {
            return SizedBox(height: 16);
          },
          itemBuilder: (context, index) {
            final item = tasksList[index];

            return InspectionListItem(
              item: item,
            );
          },
        );
      },
    );
  }
}
