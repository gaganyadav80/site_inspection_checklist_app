import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:site_inspection_checklist_app/database/local_database.dart';
import 'package:site_inspection_checklist_app/model/id_name.dart';

final statusProvider = FutureProvider<List<IdName>>(
  (ref) async {
    final database = ref.read(databaseProvider);
    await database.init();

    return database.getItemStatuses();
  },
);

final categoriesProvider = FutureProvider<List<IdName>>(
  (ref) async {
    final database = ref.read(databaseProvider);
    await database.init();

    return database.getCategories();
  },
);
