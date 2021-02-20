import 'package:json_annotation/json_annotation.dart';
part 'category.g.dart';

@JsonSerializable()
class Category {
  Category(this.name, this.identifier);

  @JsonKey(name: 'name', defaultValue: '')
  String name;

  @JsonKey(name: 'identifier', defaultValue: '')
  String identifier;
  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
