// To parse this JSON data, do
//
//     final productCartsModel = productCartsModelFromJson(jsonString);

import 'dart:convert';

ProductCartsModel productCartsModelFromJson(String str) => ProductCartsModel.fromJson(json.decode(str));

String productCartsModelToJson(ProductCartsModel data) => json.encode(data.toJson());

class ProductCartsModel {
    ProductCartsModel({
        this.productId,
        this.cartId,
        this.quantity,
    });

    String productId = ""; 
    String cartId = "";
    int quantity = 0;

    factory ProductCartsModel.fromJson(Map<String, dynamic> json) => ProductCartsModel(
        productId: json["product_id"],
        cartId: json["cart_id"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId,
        "cart_id": cartId,
        "quantity": quantity,
    };
}
