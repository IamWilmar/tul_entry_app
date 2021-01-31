import 'dart:convert';
import 'package:http/http.dart'as http;
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

  Future<List<ProductCartsModel>> cargarProductos(String cardId) async {
    final url = "https://tuldatabase-default-rtdb.firebaseio.com/products_carts.json?orderBy=\"cart_id\"&equalTo=\"$cardId\"";
    final response = await http.get(url);
    final Map<String, dynamic> data = json.decode(response.body);
    final List<ProductCartsModel> productCartList = new List();
    data.forEach((id, product){
      final tempProduct = ProductCartsModel.fromJson(product);
      tempProduct.id = id;
      productCartList.add(tempProduct);
    });
    print(data);
    return productCartList;
  }

  Future<String> getProductName(String productId)async{
    final url = "https://tuldatabase-default-rtdb.firebaseio.com/productos/$productId.json";
    final response = await http.get(url);
    final data = json.decode(response.body);
    final name = data["nombre"];
    return name;
  }

    Future<bool> deleteProductFromCart(String productinCartId) async {
    final url = "$_url/products_carts/$productinCartId.json";
    final response = await http.delete(url);
    print(json.decode(response.body));
    return true;
  }


}