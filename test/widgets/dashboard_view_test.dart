import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:site_inspection_checklist_app/core/enums.dart';
import 'package:site_inspection_checklist_app/database/local_database.dart';
import 'package:site_inspection_checklist_app/model/id_name.dart';
import 'package:site_inspection_checklist_app/model/inspection_task.dart';
import 'package:site_inspection_checklist_app/views/dashboard_view.dart';
import 'package:site_inspection_checklist_app/widgets/add_inspection_item_modal_sheet.dart';
import 'package:site_inspection_checklist_app/widgets/dashboard/dashboard_appbar.dart';
import 'package:site_inspection_checklist_app/widgets/dashboard/inspection_list_builder.dart';
import 'package:site_inspection_checklist_app/widgets/dashboard/inspection_list_item.dart';

import '../mocks.dart';

void main() {
  group('DashboardView', () {
    late MockLocalDatabase mockLocalDatabase;

    setUp(() {
      mockLocalDatabase = MockLocalDatabase();
    });

    testWidgets('renders dashboard with loading state', (tester) async {
      when(() => mockLocalDatabase.init())
          .thenAnswer((_) => Future.value(MockDatabase()));
      when(() => mockLocalDatabase.getTasks())
          .thenAnswer((_) => Future.value([]));

      await tester.pumpWidget(
        MaterialApp(
          home: ProviderScope(
            overrides: [
              databaseProvider.overrideWithValue(mockLocalDatabase),
            ],
            child: DashboardView(),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(DashboardAppBar), findsOneWidget);
      expect(find.byType(InspectionListBuilder), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('renders dashboard with data', (tester) async {
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
      ];

      when(() => mockLocalDatabase.init())
          .thenAnswer((_) => Future.value(MockDatabase()));
      when(() => mockLocalDatabase.getTasks())
          .thenAnswer((_) => Future.value(mockTasks));

      await tester.pumpWidget(
        MaterialApp(
          home: ProviderScope(
            overrides: [
              databaseProvider.overrideWithValue(mockLocalDatabase),
            ],
            child: DashboardView(),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(DashboardAppBar), findsOneWidget);
      expect(find.byType(InspectionListBuilder), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byType(InspectionListItem), findsWidgets);

      final fab = tester
          .widget<FloatingActionButton>(find.byType(FloatingActionButton));
      expect(fab.onPressed, isNotNull);
    });

    testWidgets('renders empty state', (tester) async {
      when(() => mockLocalDatabase.init())
          .thenAnswer((_) => Future.value(MockDatabase()));
      when(() => mockLocalDatabase.getTasks())
          .thenAnswer((_) => Future.value([]));

      await tester.pumpWidget(
        MaterialApp(
          home: ProviderScope(
            overrides: [
              databaseProvider.overrideWithValue(mockLocalDatabase),
            ],
            child: DashboardView(),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(InspectionListItem), findsNothing);
      expect(find.byIcon(Icons.checklist), findsOneWidget);
      expect(find.text('You haven\'t added any tasks yet'), findsOneWidget);
      expect(
        find.text(
          'All your important task related to site inspections will be listed here. Add a new task to get started.',
        ),
        findsOneWidget,
      );
    });

    testWidgets('tapping FAB opens add task modal', (tester) async {
      when(() => mockLocalDatabase.init())
          .thenAnswer((_) => Future.value(MockDatabase()));
      when(() => mockLocalDatabase.getTasks())
          .thenAnswer((_) => Future.value([]));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            databaseProvider.overrideWithValue(mockLocalDatabase),
          ],
          child: MaterialApp(
            home: DashboardView(),
          ),
        ),
      );
      await tester.pump();

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byType(AddInspectionItemModalSheet), findsOneWidget);
    });
  });
}
