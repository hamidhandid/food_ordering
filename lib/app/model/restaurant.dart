import 'package:alo_self/app/model/food.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant.g.dart';

@JsonSerializable()
class Restaurant {
  final String? id;
  final String name;
  final String area;
  final String? address;
  final List<String> service_areas;
  final String work_hour;
  final int deliver_cost;
  final List<Food>? foods;
  const Restaurant({
    required this.name,
    required this.area,
    this.address,
    required this.service_areas,
    required this.work_hour,
    required this.deliver_cost,
    this.foods,
    this.id,
  });
  factory Restaurant.fromJson(Map<String, dynamic> json) => _$RestaurantFromJson(json);
  Map<String, dynamic> toJson() => _$RestaurantToJson(this);
}
