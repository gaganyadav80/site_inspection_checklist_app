import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:site_inspection_checklist_app/database/local_database.dart';
import 'package:site_inspection_checklist_app/providers/inspection_task_notifier.dart';
import 'package:site_inspection_checklist_app/widgets/add_inspection_item_modal_sheet.dart';
import 'package:site_inspection_checklist_app/widgets/dashboard/dashboard_appbar.dart';
import 'package:site_inspection_checklist_app/widgets/dashboard/inspection_list_builder.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(databaseProvider).init();
      ref.read(inspectionTaskNotifier.notifier).fetchAllTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(),
      body: InspectionListBuilder(),
      floatingActionButton: _AddTaskFAB(),
    );
  }
}

class _AddTaskFAB extends ConsumerWidget {
  const _AddTaskFAB();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksState = ref.watch(
      inspectionTaskNotifier.select(
        (state) => state.tasksState,
      ),
    );

    return tasksState.maybeWhen(
      orElse: () {
        return SizedBox.shrink();
      },
      data: (_) {
        return FloatingActionButton(
          backgroundColor: tasksState.isLoading ? Colors.grey : null,
          onPressed: tasksState.isLoading
              ? null
              : () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return AddInspectionItemModalSheet();
                    },
                  );
                },
          child: Icon(Icons.add),
        );
      },
    );
  }
}
