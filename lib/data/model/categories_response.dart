import 'package:e_commerce/data/model/Metadata.dart';
import 'package:e_commerce/data/model/base_response.dart';

import 'dart:convert';

import 'package:e_commerce/data/model/category_dm.dart';

CategoriesResponse categoriesResponseFromJson(String str) => CategoriesResponse.fromJson(json.decode(str));
String categoriesResponseToJson(CategoriesResponse data) => json.encode(data.toJson());
class CategoriesResponse extends BaseResponse {
  CategoriesResponse({
      this.results,
      this.metadata, 
      this.data,});

  CategoriesResponse.fromJson(dynamic json) {
    message=json['message'];
    results = json['results'];
    metadata = json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CategoryDM.fromJson(v));
      });
    }
  }
  int? results;
  Metadata? metadata;
  List<CategoryDM>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['results'] = results;
    if (metadata != null) {
      map['metadata'] = metadata?.toJson();
    }
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}