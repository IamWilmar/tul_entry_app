import 'package:rxdart/rxdart.dart';
import 'package:tul_entry_app/src/models/product_carts_model.dart';

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

  updateProduct(ProductCartsModel product){
    if(product != null){
      _productIdController.sink.add(product.productId);
      _cartIdController.sink.add(product.cartId);
      _quantityController.sink.add(product.quantity);
    }else{
       _quantityController.sink.addError("Invalid value");
       _cartIdController.sink.addError("Invalid value");
       _productIdController.sink.addError("Invalid value");
    }
  }

  dispose(){
    _productIdController?.close();
    _cartIdController?.close();
    _quantityController?.close();
  }

}