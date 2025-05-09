import 'package:mocktail/mocktail.dart';
import 'package:site_inspection_checklist_app/database/local_database.dart';
import 'package:sqflite/sqflite.dart';

class MockLocalDatabase extends Mock implements LocalDatabase {}

class MockDatabase extends Mock implements Database {}
