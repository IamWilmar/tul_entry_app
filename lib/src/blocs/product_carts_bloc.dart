import 'package:rxdart/rxdart.dart';

class ProductCartsBloc{

  final _productIdController = BehaviorSubject<String>();
  final _cartIdController = BehaviorSubject<String>();
  final _quantityController = BehaviorSubject<int>();

  Stream<String> get productIdStream => _productIdController.stream;
  Stream<String> get cartIdStream => _cartIdController.stream;
  Stream<int> get quantityStream => _quantityController.stream;

  Function(String) get cambiarProductId => _productIdController.sink.add;
  Function(String) get cambiarCartId => _cartIdController.sink.add;
  Function(int) get cambiarQuantity => _quantityController.sink.add;

  String get productId => _productIdController.value;
  String get cartId => _cartIdController.value;
  int get quantity => _quantityController.value;

  updateQuantity(int number){
    number == null ? _quantityController.sink.addError("Invalid value") : _quantityController.sink.add(number);
  }

  dispose(){
    _productIdController?.close();
    _cartIdController?.close();
    _quantityController?.close();
  }

}