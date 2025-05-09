import 'dart:developer' as dev;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:site_inspection_checklist_app/core/enums.dart';
import 'package:site_inspection_checklist_app/database/local_database.dart';
import 'package:site_inspection_checklist_app/model/id_name.dart';
import 'package:site_inspection_checklist_app/model/inspection_task.dart';

final inspectionTaskNotifier =
    NotifierProvider<InspectionTaskNotifier, InspectionTaskState>(
  InspectionTaskNotifier.new,
);

class InspectionTaskNotifier extends Notifier<InspectionTaskState> {
  @override
  InspectionTaskState build() {
    return const InspectionTaskState();
  }

  void _sortTasks(List<InspectionTask> tasks) {
    tasks.sort(
      (first, second) {
        if (first.status.id == TaskStatus.pending.id &&
            second.status.id != TaskStatus.pending.id) {
          return -1;
        } else if (second.status.id == TaskStatus.pending.id &&
            first.status.id != TaskStatus.pending.id) {
          return 1;
        }
        return second.createdAt.compareTo(first.createdAt);
      },
    );
  }

  Future<void> fetchAllTasks() async {
    state = state.copyWith(
      tasksState: const AsyncValue.loading(),
    );
    try {
      final database = ref.read(databaseProvider);
      await database.init();
      final tasks = await database.getTasks();

      _sortTasks(tasks);

      state = state.copyWith(
        tasksState: AsyncValue.data(tasks),
      );
    } catch (err, st) {
      state = state.copyWith(
        tasksState: AsyncValue.error(err, st),
      );
      dev.log('fetchAllTasks', error: err, stackTrace: st);
    }
  }

  Future<void> addTask(InspectionTask task) async {
    state = state.copyWith(
      addTaskState: const AsyncValue.loading(),
    );
    try {
      final database = ref.read(databaseProvider);
      await database.init();
      await database.insertTask(task);

      final currentTasks = List<InspectionTask>.of(
        state.tasksState.valueOrNull ?? [],
      );
      currentTasks.insert(0, task);

      state = state.copyWith(
        tasksState: AsyncValue.data(currentTasks),
        addTaskState: const AsyncValue.data(null),
      );
    } catch (err, st) {
      state = state.copyWith(
        addTaskState: AsyncValue.error(err, st),
      );
      dev.log('addTask', error: err, stackTrace: st);
    }
  }

  Future<void> updateTaskStatus(int taskId, IdName status) async {
    state = state.copyWith(
      updateTaskState: const AsyncValue.loading(),
    );
    try {
      final database = ref.read(databaseProvider);
      await database.init();
      await database.updateTask(taskId, status.id);

      final currentTasks = List<InspectionTask>.of(
        state.tasksState.valueOrNull ?? [],
      );
      final index = currentTasks.indexWhere((e) => e.id == taskId);
      if (index != -1) {
        final updatedTask = currentTasks[index].copyWith(status: status);
        currentTasks[index] = updatedTask;
      }

      _sortTasks(currentTasks);

      state = state.copyWith(
        tasksState: AsyncValue.data(currentTasks),
        updateTaskState: const AsyncValue.data(null),
      );
    } catch (err, st) {
      state = state.copyWith(
        updateTaskState: AsyncValue.error(err, st),
      );
      dev.log('updateTask', error: err, stackTrace: st);
    }
  }

  Future<void> resetAllTaskStatuses() async {
    state = state.copyWith(
      resetAllTaskStatusesState: const AsyncValue.loading(),
    );
    try {
      final database = ref.read(databaseProvider);
      await database.init();
      await database.resetAllTaskStatuses();

      final IdName status = IdName(
        id: TaskStatus.pending.id,
        name: TaskStatus.pending.name,
      );
      final currentTasks = state.tasksState.valueOrNull
              ?.map((e) => e.copyWith(status: status))
              .toList() ??
          [];

      _sortTasks(currentTasks);

      state = state.copyWith(
        tasksState: AsyncValue.data(currentTasks),
        resetAllTaskStatusesState: const AsyncValue.data(null),
      );
    } catch (err, st) {
      state = state.copyWith(
        resetAllTaskStatusesState: AsyncValue.error(err, st),
      );
      dev.log('resetAllTaskStatuses', error: err, stackTrace: st);
    }
  }
}

class InspectionTaskState {
  const InspectionTaskState({
    this.tasksState = const AsyncValue.loading(),
    this.addTaskState = const AsyncValue.data(null),
    this.updateTaskState = const AsyncValue.data(null),
    this.resetAllTaskStatusesState = const AsyncValue.data(null),
  });

  final AsyncValue<List<InspectionTask>> tasksState;
  final AsyncValue<void> addTaskState;
  final AsyncValue<void> updateTaskState;
  final AsyncValue<void> resetAllTaskStatusesState;

  InspectionTaskState copyWith({
    AsyncValue<List<InspectionTask>>? tasksState,
    AsyncValue<void>? addTaskState,
    AsyncValue<void>? updateTaskState,
    AsyncValue<void>? resetAllTaskStatusesState,
  }) {
    return InspectionTaskState(
      tasksState: tasksState ?? this.tasksState,
      addTaskState: addTaskState ?? this.addTaskState,
      updateTaskState: updateTaskState ?? this.updateTaskState,
      resetAllTaskStatusesState:
          resetAllTaskStatusesState ?? this.resetAllTaskStatusesState,
    );
  }
}
