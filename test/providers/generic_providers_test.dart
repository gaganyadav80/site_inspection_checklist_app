import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:site_inspection_checklist_app/database/local_database.dart';
import 'package:site_inspection_checklist_app/model/id_name.dart';
import 'package:site_inspection_checklist_app/providers/generic_providers.dart';

import '../mocks.dart';

void main() {
  group('generic providers', () {
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

    test('statusProvider returns list of IdName', () async {
      final expectedStatuses = [
        IdName(id: 1, name: 'Pending'),
        IdName(id: 2, name: 'Completed'),
      ];

      when(() => mockLocalDatabase.init())
          .thenAnswer((_) => Future.value(MockDatabase()));

      when(() => mockLocalDatabase.getItemStatuses())
          .thenAnswer((_) => Future.value(expectedStatuses));

      final result = await container.read(statusProvider.future);

      expect(result, equals(expectedStatuses));
    });

    test('categoriesProvider returns list of IdName', () async {
      final expectedCategories = [
        IdName(id: 1, name: 'Safety'),
        IdName(id: 2, name: 'Quality'),
      ];

      when(() => mockLocalDatabase.init())
          .thenAnswer((_) => Future.value(MockDatabase()));

      when(() => mockLocalDatabase.getCategories())
          .thenAnswer((_) => Future.value(expectedCategories));

      final result = await container.read(categoriesProvider.future);

      expect(result, equals(expectedCategories));
    });

    test('statusProvider handles database initialization error', () async {
      when(() => mockLocalDatabase.init()).thenAnswer(
          (_) => Future.error(Exception('Database initialization failed')));

      expect(
        () => container.read(statusProvider.future),
        throwsA(isA<Exception>().having((e) => e.toString(), 'message',
            contains('Database initialization failed'))),
      );
    });

    test('categoriesProvider handles database initialization error', () async {
      when(() => mockLocalDatabase.init()).thenAnswer(
          (_) => Future.error(Exception('Database initialization failed')));

      expect(
        () => container.read(categoriesProvider.future),
        throwsA(isA<Exception>().having((e) => e.toString(), 'message',
            contains('Database initialization failed'))),
      );
    });
  });
}
