import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:tul_entry_app/src/models/product_model.dart';

class ProductosProvider{
  
  final String _url = "https://tuldatabase-default-rtdb.firebaseio.com";

  Future<bool> crearProducto(ProductModel producto) async {
    final url = '$_url/productos.json';
    final response = await http.post(url, body: productModelToJson(producto));
    final data = json.decode(response.body);
    print(data);
    return true;
  }

  Future<List<ProductModel>> cargarProductos() async {
    final url = "$_url/productos.json";
    final response = await http.get(url);
    final Map<String, dynamic> data = json.decode(response.body);
    final List<ProductModel> productList = new List();
    if(data == null) return [];
    data.forEach((id, product){
      final temporalProduts = ProductModel.fromJson(product);
      temporalProduts.id = id;
      productList.add(temporalProduts);
    });
    print(data);
    return productList;
  }

}