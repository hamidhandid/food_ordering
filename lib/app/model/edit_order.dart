import 'package:alo_self/app/model/user_profile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_order.g.dart';

@JsonSerializable()
class EditOrder {
  final String status;
  final UserProfile? sender;
  const EditOrder({
    required this.status,
    this.sender,
  });
  factory EditOrder.fromJson(Map<String, dynamic> json) => _$EditOrderFromJson(json);
  Map<String, dynamic> toJson() => _$EditOrderToJson(this);
}
