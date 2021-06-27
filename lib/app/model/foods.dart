import 'package:json_annotation/json_annotation.dart';

import 'food.dart';

part 'foods.g.dart';

@JsonSerializable()
class Foods {
  final List<Food>? foods;
  const Foods({this.foods});
  factory Foods.fromJson(Map<String, dynamic> json) => _$FoodsFromJson(json);
  Map<String, dynamic> toJson() => _$FoodsToJson(this);
}
