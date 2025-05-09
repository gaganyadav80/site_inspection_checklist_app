import 'package:site_inspection_checklist_app/model/id_name.dart';

enum TaskStatus {
  passed(id: 1, name: 'Passed'),
  failed(id: 2, name: 'Failed'),
  notApplicable(id: 3, name: 'Not Applicable'),
  pending(id: 4, name: 'Pending');

  const TaskStatus({required this.id, required this.name});
  final int id;
  final String name;

  IdName get idName => IdName(id: id, name: name);

  static TaskStatus fromId(int id) {
    return TaskStatus.values.firstWhere((element) => element.id == id);
  }
}

enum TaskCategory {
  safety(id: 1, name: 'Safety'),
  electrical(id: 2, name: 'Electrical'),
  fireSafety(id: 3, name: 'Fire Safety'),
  structural(id: 4, name: 'Structural'),
  hazardousMaterials(id: 5, name: 'Hazardous Materials'),
  environmental(id: 6, name: 'Environmental'),
  maintenance(id: 7, name: 'Maintenance'),
  medical(id: 8, name: 'Medical');

  const TaskCategory({required this.id, required this.name});
  final int id;
  final String name;
}
