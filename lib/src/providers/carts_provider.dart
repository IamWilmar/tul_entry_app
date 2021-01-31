import 'package:tul_entry_app/src/models/carts_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CartsProvider {
  final String _url = "https://tuldatabase-default-rtdb.firebaseio.com";

  Future<String> crearCarrito(CartsModel producto) async {
    String cartId = await getCurrentCart();
    if (cartId != "" && cartId != null) {
      return cartId;
    } else {
      final url = '$_url/carts.json';
      final response = await http.post(url, body: cartsModelToJson(producto));
      final data = json.decode(response.body);
      print(data["name"]);
      cartId = data["name"];
      return cartId;
    }
  }

  Future<String> getCurrentCart() async {
    String output;
    try {
      final url =
          "https://tuldatabase-default-rtdb.firebaseio.com/carts.json?orderBy=\"status\"&equalTo=\"pending\"";
      final response = await http.get(url);
      final Map<String, dynamic> data = json.decode(response.body);
      output = data.keys.first;
    } catch (e) {
      output = "";
    }
    return output;
  }

  Future<List<CartsModel>> getAllCarts() async {
    final url = "https://tuldatabase-default-rtdb.firebaseio.com/carts.json?orderBy=\"status\"";
    final response = await http.get(url);
    final Map<String, dynamic> data = json.decode(response.body);
    final List<CartsModel> cartsList = new List();
    if (data == null) return [];
    data.forEach((id, product) {
      final temporalProduts = CartsModel.fromJson(product);
      temporalProduts.id = id;
      cartsList.add(temporalProduts);
    });
    print(data);
    return cartsList;
  }

  Future<bool> editCartStatus(CartsModel cart) async {
    final url = "$_url/carts/${cart.id}.json";
    cart.status = "completed";
    final response = await http.put(url, body: cartsModelToJson(cart));
    final data = json.decode(response.body);
    print(data);
    return true;
  }

}
