import 'package:equatable/equatable.dart';
import 'package:site_inspection_checklist_app/model/id_name.dart';

class InspectionTask extends Equatable {
  const InspectionTask({
    required this.id,
    required this.name,
    required this.status,
    required this.category,
    required this.createdAt,
    required this.modifiedAt,
  });

  final int id;
  final String name;
  final IdName status;
  final IdName category;
  final DateTime createdAt;
  final DateTime modifiedAt;

  factory InspectionTask.fromJson(Map<String, dynamic> json) => InspectionTask(
        id: json["id"],
        name: json["name"],
        status: IdName.fromJson(json["status"]),
        category: IdName.fromJson(json["category"]),
        createdAt: DateTime.parse(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status.toJson(),
        "category": category.toJson(),
        "created_at": createdAt.toIso8601String(),
        "modified_at": modifiedAt.toIso8601String(),
      };

  @override
  List<Object?> get props => [id, name, status, category];

  InspectionTask copyWith({
    int? id,
    String? name,
    IdName? status,
    IdName? category,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) {
    return InspectionTask(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }
}
