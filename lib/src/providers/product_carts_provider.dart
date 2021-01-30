import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:tul_entry_app/src/models/carts_model.dart';
import 'package:tul_entry_app/src/models/product_carts_model.dart';


class ProductsCartsProvider{
  final String _url = "https://tuldatabase-default-rtdb.firebaseio.com";

  Future<bool> crearProductoCarrito(ProductCartsModel producto) async {
    final url = '$_url/products_carts.json';
    final response = await http.post(url, body: productCartsModelToJson(producto));
    final data = json.decode(response.body);
    print(data);
    return true;
  }

  Future<List<CartsModel>> cargarProductos(String cardId) async {
    final url = "$_url/products_carts.json?orderBy=\"cart_id\"&equalTo=$cardId";
    final response = await http.get(url);
    final Map<String, dynamic> data = json.decode(response.body);
    final List<CartsModel> productList = new List();
    if(data == null) return [];
    data.forEach((id, product){
      final temporalProduts = CartsModel.fromJson(product);
      temporalProduts.id = id;
      productList.add(temporalProduts);
    });
    print(data);
    return productList;
  }

}