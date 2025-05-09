import 'package:equatable/equatable.dart';

class IdName extends Equatable {
  const IdName({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory IdName.fromJson(Map<String, dynamic> json) => IdName(
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
