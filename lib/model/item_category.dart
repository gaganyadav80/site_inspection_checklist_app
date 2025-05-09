import 'package:equatable/equatable.dart';

class ItemCategory extends Equatable {
  const ItemCategory({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory ItemCategory.fromJson(Map<String, dynamic> json) => ItemCategory(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  @override
  List<Object?> get props => [id, name];
}
