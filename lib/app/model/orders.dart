import 'package:json_annotation/json_annotation.dart';

import 'order.dart';

part 'orders.g.dart';

@JsonSerializable()
class Orders {
  final List<Order>? orders;
  const Orders({this.orders});
  factory Orders.fromJson(Map<String, dynamic> json) => _$OrdersFromJson(json);
  Map<String, dynamic> toJson() => _$OrdersToJson(this);
}
