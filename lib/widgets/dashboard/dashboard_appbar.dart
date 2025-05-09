import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:site_inspection_checklist_app/providers/inspection_task_notifier.dart';
import 'package:site_inspection_checklist_app/widgets/dashboard/dashboard_task_summary_tile.dart';
import 'package:site_inspection_checklist_app/widgets/secondary_button.dart';

class DashboardAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const DashboardAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resetAllTaskStatusesState = ref.watch(
      inspectionTaskNotifier.select(
        (state) => state.resetAllTaskStatusesState,
      ),
    );

    final tasksState = ref.watch(
      inspectionTaskNotifier.select(
        (state) => state.tasksState,
      ),
    );

    final hasTasks =
        tasksState.valueOrNull != null && tasksState.valueOrNull!.isNotEmpty;

    return AppBar(
      title: Text('Site Inspection'),
      actions: [
        if (hasTasks)
          SizedBox(
            height: 36,
            child: SecondaryButton(
              onPressed: resetAllTaskStatusesState.isLoading
                  ? null
                  : () {
                      ref
                          .read(inspectionTaskNotifier.notifier)
                          .resetAllTaskStatuses();
                    },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (resetAllTaskStatusesState.isLoading)
                    const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    )
                  else ...[
                    Icon(Icons.sync_rounded),
                    SizedBox(width: 4),
                    Text('Reset'),
                  ],
                ],
              ),
            ),
          ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(90 - kToolbarHeight),
        child: DashboardTaskSummaryTile(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}
