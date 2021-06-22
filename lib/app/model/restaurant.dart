import 'package:alo_self/app/model/food.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant.g.dart';

@JsonSerializable()
class Restaurant {
  final String name;
  final String area;
  final String address;
  final List<String> service_areas;
  final String work_hour;
  final int deliver_cost;
  final List<Food> menu;
  const Restaurant({
    required this.name,
    required this.area,
    required this.address,
    required this.service_areas,
    required this.work_hour,
    required this.deliver_cost,
    required this.menu,
  });
  factory Restaurant.fromJson(Map<String, dynamic> json) => _$RestaurantFromJson(json);
  Map<String, dynamic> toJson() => _$RestaurantToJson(this);
}
