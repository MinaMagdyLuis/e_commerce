import 'package:e_commerce/data/model/product_dm.dart';

import 'dart:convert';

CartProduct productsFromJson(String str) => CartProduct.fromJson(json.decode(str));
String productsToJson(CartProduct data) => json.encode(data.toJson());
class CartProduct {
  CartProduct({
      this.count, 
      this.id, 
      this.product, 
      this.price,});

  CartProduct.fromJson(dynamic json) {
    count = json['count'];
    id = json['_id'];
    product = json['product'] != null ? ProductDM.fromJson(json['product']) : null;
    price = json['price'];
  }
  int? count;
  String? id;
  ProductDM? product;
  int? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['_id'] = id;
    if (product != null) {
      map['product'] = product?.toJson();
    }
    map['price'] = price;
    return map;
  }

}