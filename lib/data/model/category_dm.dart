import 'dart:convert';

CategoryDM dataFromJson(String str) => CategoryDM.fromJson(json.decode(str));
String dataToJson(CategoryDM data) => json.encode(data.toJson());
class CategoryDM {
  CategoryDM({
      this.id, 
      this.name, 
      this.slug, 
      this.image, 
      this.createdAt,
    this.category,
      this.updatedAt,});

  CategoryDM.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    category = json['category'];
  }
  String? id;
  String? name;
  String? slug;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['image'] = image;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

}