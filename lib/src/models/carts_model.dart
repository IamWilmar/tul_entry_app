// To parse this JSON data, do
//
//     final cartsModel = cartsModelFromJson(jsonString);

import 'dart:convert';

CartsModel cartsModelFromJson(String str) => CartsModel.fromJson(json.decode(str));

String cartsModelToJson(CartsModel data) => json.encode(data.toJson());

class CartsModel {
    CartsModel({
        this.id,
        this.status,
    });

    String id;
    String status = "";

    factory CartsModel.fromJson(Map<String, dynamic> json) => CartsModel(
        id: json["id"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
    };
}
