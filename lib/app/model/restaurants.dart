import 'package:alo_self/app/model/restaurant.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurants.g.dart';

@JsonSerializable()
class Restaurants {
  final List<Restaurant> restaurants;
  const Restaurants({
    required this.restaurants,
  });
  factory Restaurants.fromJson(Map<String, dynamic> json) => _$RestaurantsFromJson(json);
  Map<String, dynamic> toJson() => _$RestaurantsToJson(this);
}
