import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:site_inspection_checklist_app/core/enums.dart';
import 'package:site_inspection_checklist_app/database/local_database.dart';
import 'package:site_inspection_checklist_app/model/id_name.dart';
import 'package:site_inspection_checklist_app/model/inspection_task.dart';
import 'package:site_inspection_checklist_app/providers/inspection_task_notifier.dart';
import 'package:sqflite/sqflite.dart';

// Define mock classes
class MockLocalDatabase extends Mock implements LocalDatabase {}

class MockDatabase extends Mock implements Database {}

void main() {
  group('InspectionTaskNotifier', () {
    late ProviderContainer container;
    late MockLocalDatabase mockLocalDatabase;

    setUp(() {
      mockLocalDatabase = MockLocalDatabase();
      container = ProviderContainer(
        overrides: [
          databaseProvider.overrideWithValue(mockLocalDatabase),
        ],
      );
      addTearDown(container.dispose);
    });

    test('initial state is correct', () {
      final state = container.read(inspectionTaskNotifier.notifier).build();
      expect(state, isA<InspectionTaskState>());
      expect(
          state.tasksState, const AsyncValue<List<InspectionTask>>.loading());
      expect(state.addTaskState, const AsyncValue<void>.data(null));
      expect(state.updateTaskState, const AsyncValue<void>.data(null));
      expect(
          state.resetAllTaskStatusesState, const AsyncValue<void>.data(null));
    });

    group('fetchAllTasks', () {
      final mockTasks = [
        InspectionTask(
          id: 1,
          name: 'Safety Check',
          status:
              IdName(id: TaskStatus.pending.id, name: TaskStatus.pending.name),
          category: IdName(
              id: TaskCategory.safety.id, name: TaskCategory.safety.name),
          createdAt: DateTime(2025, 5, 10),
          modifiedAt: DateTime(2025, 5, 10),
        ),
        InspectionTask(
          id: 2,
          name: 'Electrical Check',
          status:
              IdName(id: TaskStatus.passed.id, name: TaskStatus.passed.name),
          category: IdName(
              id: TaskCategory.electrical.id,
              name: TaskCategory.electrical.name),
          createdAt: DateTime(2025, 5, 9),
          modifiedAt: DateTime(2025, 5, 9),
        ),
      ];

      test('returns list of tasks', () async {
        when(() => mockLocalDatabase.init())
            .thenAnswer((_) => Future.value(MockDatabase()));
        when(() => mockLocalDatabase.getTasks())
            .thenAnswer((_) => Future.value(mockTasks));

        await container.read(inspectionTaskNotifier.notifier).fetchAllTasks();

        final state = container.read(inspectionTaskNotifier);
        expect(state.tasksState.value, isA<List<InspectionTask>>());
        expect(state.tasksState.value, hasLength(2));
        expect(state.tasksState.value?[0].status.id, TaskStatus.pending.id);
        expect(state.tasksState.value?[1].status.id, TaskStatus.passed.id);
      });

      test('handles database initialization error', () async {
        when(() => mockLocalDatabase.init())
            .thenAnswer((_) => Future.value(MockDatabase()));
        when(() => mockLocalDatabase.getTasks()).thenAnswer(
            (_) => Future.error(Exception('Database initialization failed')));

        await container.read(inspectionTaskNotifier.notifier).fetchAllTasks();

        final state = container.read(inspectionTaskNotifier);
        expect(state.tasksState.hasError, isTrue);

        expect(
          state.tasksState.error,
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Database initialization failed'),
          ),
        );
      });
    });

    group('addTask', () {
      final newTask = InspectionTask(
        id: 1,
        name: 'New Task',
        status:
            IdName(id: TaskStatus.pending.id, name: TaskStatus.pending.name),
        category:
            IdName(id: TaskCategory.safety.id, name: TaskCategory.safety.name),
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
      );

      test('adds new task to the beginning of list', () async {
        when(() => mockLocalDatabase.init())
            .thenAnswer((_) => Future.value(MockDatabase()));
        when(() => mockLocalDatabase.insertTask(newTask))
            .thenAnswer((_) => Future.value());

        await container.read(inspectionTaskNotifier.notifier).addTask(newTask);

        final state = container.read(inspectionTaskNotifier);
        expect(state.tasksState.value, isA<List<InspectionTask>>());
        expect(state.tasksState.value, hasLength(1));
        expect(state.tasksState.value?[0], equals(newTask));
        expect(state.addTaskState, const AsyncValue<void>.data(null));
      });
    });

    group('updateTaskStatus', () {
      final task = InspectionTask(
        id: 1,
        name: 'Task to Update',
        status:
            IdName(id: TaskStatus.pending.id, name: TaskStatus.pending.name),
        category:
            IdName(id: TaskCategory.safety.id, name: TaskCategory.safety.name),
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
      );
      final updatedStatus =
          IdName(id: TaskStatus.passed.id, name: TaskStatus.passed.name);

      test('updates task status and maintains sort order', () async {
        when(() => mockLocalDatabase.init())
            .thenAnswer((_) => Future.value(MockDatabase()));
        when(() => mockLocalDatabase.getTasks())
            .thenAnswer((_) => Future.value([task]));
        when(() => mockLocalDatabase.updateTask(task.id, updatedStatus.id))
            .thenAnswer((_) => Future.value());

        await container.read(inspectionTaskNotifier.notifier).fetchAllTasks();

        await container
            .read(inspectionTaskNotifier.notifier)
            .updateTaskStatus(task.id, updatedStatus);

        final state = container.read(inspectionTaskNotifier);
        expect(state.tasksState.value, isA<List<InspectionTask>>());
        expect(state.tasksState.value?[0].status.id, TaskStatus.passed.id);
        expect(state.updateTaskState, const AsyncValue<void>.data(null));
      });
    });

    group('resetAllTaskStatuses', () {
      final mockTasks = [
        InspectionTask(
          id: 1,
          name: 'Task 1',
          status:
              IdName(id: TaskStatus.passed.id, name: TaskStatus.passed.name),
          category: IdName(
              id: TaskCategory.safety.id, name: TaskCategory.safety.name),
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now(),
        ),
        InspectionTask(
          id: 2,
          name: 'Task 2',
          status:
              IdName(id: TaskStatus.failed.id, name: TaskStatus.failed.name),
          category: IdName(
              id: TaskCategory.electrical.id,
              name: TaskCategory.electrical.name),
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now(),
        ),
      ];

      test('resets all task statuses to pending', () async {
        when(() => mockLocalDatabase.init())
            .thenAnswer((_) => Future.value(MockDatabase()));
        when(() => mockLocalDatabase.getTasks())
            .thenAnswer((_) => Future.value(mockTasks));
        when(() => mockLocalDatabase.resetAllTaskStatuses())
            .thenAnswer((_) => Future.value());

        await container.read(inspectionTaskNotifier.notifier).fetchAllTasks();

        await container
            .read(inspectionTaskNotifier.notifier)
            .resetAllTaskStatuses();

        final state = container.read(inspectionTaskNotifier);
        expect(state.tasksState.value, isA<List<InspectionTask>>());
        expect(state.tasksState.value, hasLength(2));
        expect(state.tasksState.value?[0].status.id, TaskStatus.pending.id);
        expect(state.tasksState.value?[1].status.id, TaskStatus.pending.id);
        expect(
          state.resetAllTaskStatusesState,
          const AsyncValue<void>.data(null),
        );
      });
    });
  });
}
