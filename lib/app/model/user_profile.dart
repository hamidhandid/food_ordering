import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile {
  final String first_name;
  final String last_name;
  final String area;
  final String address;
  final int? credit;
  final List? orders_history;
  final List? favorits;
  final String? id;
  const UserProfile({
    required this.first_name,
    required this.last_name,
    required this.area,
    required this.address,
    this.credit,
    this.orders_history,
    this.favorits,
    this.id,
  });
  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
