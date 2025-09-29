import 'package:e_commerce/data/model/base_response.dart';

import 'cart_dm.dart';
import 'dart:convert';

CartResponse cartResponseFromJson(String str) => CartResponse.fromJson(json.decode(str));
String cartResponseToJson(CartResponse data) => json.encode(data.toJson());
class CartResponse extends BaseResponse{
  CartResponse({
      this.status, 
      this.numOfCartItems, 
      this.cartId, 
      this.cartDM,});

  CartResponse.fromJson(dynamic json) {
    status = json['status'];
    message=json['message'];
    numOfCartItems = json['numOfCartItems'];
    cartId = json['cartId'];
    cartDM = json['data'] != null ? CartDM.fromJson(json['data']) : null;
  }
  String? status;
  int? numOfCartItems;
  String? cartId;
  CartDM? cartDM;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['numOfCartItems'] = numOfCartItems;
    map['cartId'] = cartId;
    if (cartDM != null) {
      map['data'] = cartDM?.toJson();
    }
    return map;
  }

}