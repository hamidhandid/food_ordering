import 'package:json_annotation/json_annotation.dart';

part 'manager.g.dart';

@JsonSerializable()
class Manager {
  final String email;
  final String password;
  const Manager({required this.email, required this.password});
  factory Manager.fromJson(Map<String, dynamic> json) => _$ManagerFromJson(json);
  Map<String, dynamic> toJson() => _$ManagerToJson(this);
}