import 'Metadata.dart';
import 'product_dm.dart';
import 'dart:convert';

ProductsResponse productsResponseFromJson(String str) => ProductsResponse.fromJson(json.decode(str));
String productsResponseToJson(ProductsResponse data) => json.encode(data.toJson());
class ProductsResponse {
  ProductsResponse({
      this.results, 
      this.metadata, 
      this.data,});

  ProductsResponse.fromJson(dynamic json) {
    results = json['results'];
    metadata = json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ProductDM.fromJson(v));
      });
    }
  }
  num? results;
  Metadata? metadata;
  List<ProductDM>? data;

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