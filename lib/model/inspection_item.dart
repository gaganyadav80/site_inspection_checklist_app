import 'package:equatable/equatable.dart';

class InspectionItem extends Equatable {
  const InspectionItem({
    required this.id,
    required this.name,
    required this.status,
    required this.category,
  });

  final int id;
  final String name;
  final String status;
  final String category;

  factory InspectionItem.fromJson(Map<String, dynamic> json) => InspectionItem(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "category": category,
      };

  @override
  List<Object?> get props => [id, name, status, category];
}
