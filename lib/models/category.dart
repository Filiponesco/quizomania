import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category{
  final int id;
  @JsonKey(name: 'name')
  final String category;

  Category(this.id, this.category);

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  static List<Category> listFromJson(List<dynamic> list) =>
      list == null
          ? List<Category>()
          : list.map<Category>((dynamic value) => Category.fromJson(value)).toList();
}
