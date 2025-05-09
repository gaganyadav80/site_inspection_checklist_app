import 'package:equatable/equatable.dart';

class ItemStatus extends Equatable {
  const ItemStatus({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory ItemStatus.fromJson(Map<String, dynamic> json) => ItemStatus(
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
