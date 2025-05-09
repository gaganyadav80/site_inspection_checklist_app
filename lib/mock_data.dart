import 'dart:convert';

import 'package:site_inspection_checklist_app/model/inspection_task.dart';
import 'package:site_inspection_checklist_app/model/item_category.dart';
import 'package:site_inspection_checklist_app/model/item_status.dart';

final mockDataJson = '''
[
  {
    "id": 1,
    "name": "Scaffolding Safety",
    "status": {
      "id": 1,
      "name": "Passed"
    },
    "category": {
      "id": 1,
      "name": "Safety"
    }
  },
  {
    "id": 2,
    "name": "Electrical Wiring",
    "status": {
      "id": 2,
      "name": "Failed"
    },
    "category": {
      "id": 2,
      "name": "Electrical"
    }
  },
  {
    "id": 3,
    "name": "Personal Protective Equipment",
    "status": {
      "id": 3,
      "name": "Not Applicable"
    },
    "category": {
      "id": 1,
      "name": "Safety"
    }
  },
  {
    "id": 4,
    "name": "Fire Extinguishers",
    "status": {
      "id": 4,
      "name": "Pending"
    },
    "category": {
      "id": 3,
      "name": "Fire Safety"
    }
  },
  {
    "id": 5,
    "name": "Structural Integrity",
    "status": {
      "id": 4,
      "name": "Pending"
    },
    "category": {
      "id": 4,
      "name": "Structural"
    }
  },
  {
    "id": 6,
    "name": "Hazardous Materials Storage",
    "status": {
      "id": 4,
      "name": "Pending"
    },
    "category": {
      "id": 5,
      "name": "Hazardous Materials"
    }
  },
  {
    "id": 7,
    "name": "Ventilation Systems",
    "status": {
      "id": 4,
      "name": "Pending"
    },
    "category": {
      "id": 6,
      "name": "Environmental"
    }
  },
  {
    "id": 8,
    "name": "Emergency Exits",
    "status": {
      "id": 4,
      "name": "Pending"
    },
    "category": {
      "id": 3,
      "name": "Fire Safety"
    }
  },
  {
    "id": 9,
    "name": "Lighting Conditions",
    "status": {
      "id": 4,
      "name": "Pending"
    },
    "category": {
      "id": 2,
      "name": "Electrical"
    }
  },
  {
    "id": 10,
    "name": "Tripping Hazards",
    "status": {
      "id": 4,
      "name": "Pending"
    },
    "category": {
      "id": 1,
      "name": "Safety"
    }
  },
  {
    "id": 11,
    "name": "Equipment Maintenance",
    "status": {
      "id": 4,
      "name": "Pending"
    },
    "category": {
      "id": 7,
      "name": "Maintenance"
    }
  },
  {
    "id": 12,
    "name": "First Aid Supplies",
    "status": {
      "id": 4,
      "name": "Pending"
    },
    "category": {
      "id": 8,
      "name": "Medical"
    }
  }
]
''';

List<InspectionTask> mockData = (jsonDecode(mockDataJson) as List<dynamic>)
    .map((e) => InspectionTask.fromJson(e))
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

final _mockItemStatusesJson = '''
[
  {
    "id": 1,
    "name": "Passed"
  },
  {
    "id": 2,
    "name": "Failed"
  },
  {
    "id": 3,
    "name": "Not Applicable"
  }
]
''';

List<ItemStatus> mockItemStatuses =
    (jsonDecode(_mockItemStatusesJson) as List<dynamic>)
        .map((e) => ItemStatus.fromJson(e))
        .toList();
