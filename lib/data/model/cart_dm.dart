import 'cart_product.dart';
import 'dart:convert';

CartDM dataFromJson(String str) => CartDM.fromJson(json.decode(str));
String dataToJson(CartDM data) => json.encode(data.toJson());
class CartDM {
  CartDM({
      this.id, 
      this.cartOwner, 
      this.cartProducts,
      this.createdAt, 
      this.updatedAt, 
      this.v, 
      this.totalCartPrice,});

  CartDM.fromJson(dynamic json) {
    id = json['_id'];
    cartOwner = json['cartOwner'];
    if (json['products'] != null) {
      cartProducts = [];
      json['products'].forEach((v) {
        cartProducts?.add(CartProduct.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    totalCartPrice = json['totalCartPrice'];
  }
  String? id;
  String? cartOwner;
  List<CartProduct>? cartProducts;
  String? createdAt;
  String? updatedAt;
  int? v;
  int? totalCartPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['cartOwner'] = cartOwner;
    if (cartProducts != null) {
      map['products'] = cartProducts?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['totalCartPrice'] = totalCartPrice;
    return map;
  }

}