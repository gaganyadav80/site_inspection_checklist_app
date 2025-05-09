import 'dart:convert';

import 'package:site_inspection_checklist_app/model/category.dart';
import 'package:site_inspection_checklist_app/model/inspection_item.dart';

final mockDataJson = '''
[
  {
    "id": 1,
    "name": "Scaffolding Safety",
    "status": "passed",
    "category": "Safety"
  },
  {
    "id": 2,
    "name": "Electrical Wiring",
    "status": "failed",
    "category": "Electrical"
  },
  {
    "id": 3,
    "name": "Personal Protective Equipment",
    "status": "not_applicable",
    "category": "Safety"
  },
  {
    "id": 4,
    "name": "Fire Extinguishers",
    "status": "pending",
    "category": "Fire Safety"
  },
  {
    "id": 5,
    "name": "Structural Integrity",
    "status": "pending",
    "category": "Structural"
  },
  {
    "id": 6,
    "name": "Hazardous Materials Storage",
    "status": "pending",
    "category": "Hazardous Materials"
  },
  {
    "id": 7,
    "name": "Ventilation Systems",
    "status": "pending",
    "category": "Environmental"
  },
  {
    "id": 8,
    "name": "Emergency Exits",
    "status": "pending",
    "category": "Fire Safety"
  },
  {
    "id": 9,
    "name": "Lighting Conditions",
    "status": "pending",
    "category": "Electrical"
  },
  {
    "id": 10,
    "name": "Tripping Hazards",
    "status": "pending",
    "category": "Safety"
  },
  {
    "id": 11,
    "name": "Equipment Maintenance",
    "status": "pending",
    "category": "Maintenance"
  },
  {
    "id": 12,
    "name": "First Aid Supplies",
    "status": "pending",
    "category": "Medical"
  }
]
''';

List<InspectionItem> mockData = (jsonDecode(mockDataJson) as List<dynamic>)
    .map((e) => InspectionItem.fromJson(e))
    .toList();

final _mockCategoriesJson = '''
[
  {
    "id": 1,
    "name": "Safety"
  },
  {
    "id": 2,
    "name": "Electrical"
  },
  {
    "id": 3,
    "name": "Fire Safety"
  },
  {
    "id": 4,
    "name": "Structural"
  },
  {
    "id": 5,
    "name": "Hazardous Materials"
  },
  {
    "id": 6,
    "name": "Environmental"
  },
  {
    "id": 7,
    "name": "Maintenance"
  },
  {
    "id": 8,
    "name": "Medical"
  }
]
''';

List<ItemCategory> mockCategories =
    (jsonDecode(_mockCategoriesJson) as List<dynamic>)
        .map((e) => ItemCategory.fromJson(e))
        .toList();
