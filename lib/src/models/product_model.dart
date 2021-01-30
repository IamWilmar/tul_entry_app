import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
    ProductModel({
        this.id,
        this.nombre,
        this.sku,
        this.descripcion,
    });

    String id;
    String nombre = "";
    String sku = "";
    String descripcion = "";

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        nombre: json["nombre"],
        sku: json["sku"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "sku": sku,
        "descripcion": descripcion,
    };
}
