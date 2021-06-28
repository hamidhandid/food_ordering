import 'package:alo_self/app/model/food.dart';
import 'package:alo_self/app/model/restaurant.dart';
import 'package:alo_self/app/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  final String? id;
  final List<Food> foods;
  final DateTime? time;
  final Restaurant? restaurant;
  final User? customer;
  final String? status;
  const Order({
    required this.foods,
    this.time,
    this.id,
    this.restaurant,
    this.customer,
    this.status,
  });
  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
