// To parse this JSON data, do
//
//     final productCartsModel = productCartsModelFromJson(jsonString);

import 'dart:convert';

ProductCartsModel productCartsModelFromJson(String str) => ProductCartsModel.fromJson(json.decode(str));

String productCartsModelToJson(ProductCartsModel data) => json.encode(data.toJson());

class ProductCartsModel {
    ProductCartsModel({
        this.id,
        this.productId,
        this.cartId,
        this.quantity,
    });

    String id;
    String productId = ""; 
    String cartId = "";
    int quantity = 0;

    factory ProductCartsModel.fromJson(Map<String, dynamic> json) => ProductCartsModel(
        id: json["id"],
        productId: json["product_id"],
        cartId: json["cart_id"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "cart_id": cartId,
        "quantity": quantity,
    };
}
