import 'package:json_annotation/json_annotation.dart';

part 'food.g.dart';

@JsonSerializable()
class Food {
  final String name;
  final int cost;
  final bool orderable;
  final String? id;
  // final String? restaurant_id;
  final int? number;
  const Food({required this.name, required this.cost, this.orderable = true, this.id, this.number});
  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);
  Map<String, dynamic> toJson() => _$FoodToJson(this);
}
