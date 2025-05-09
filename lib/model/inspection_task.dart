import 'package:equatable/equatable.dart';
import 'package:site_inspection_checklist_app/model/item_category.dart';
import 'package:site_inspection_checklist_app/model/item_status.dart';

class InspectionTask extends Equatable {
  const InspectionTask({
    required this.id,
    required this.name,
    required this.status,
    required this.category,
  });

  final int id;
  final String name;
  final ItemStatus status;
  final ItemCategory category;

  factory InspectionTask.fromJson(Map<String, dynamic> json) => InspectionTask(
        id: json["id"],
        name: json["name"],
        status: ItemStatus.fromJson(json["status"]),
        category: ItemCategory.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status.toJson(),
        "category": category.toJson(),
      };

  @override
  List<Object?> get props => [id, name, status, category];
}
