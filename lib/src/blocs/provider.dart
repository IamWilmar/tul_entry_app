import 'package:flutter/material.dart';
import 'package:tul_entry_app/src/blocs/cart_bloc.dart';
import 'package:tul_entry_app/src/blocs/create_product_bloc.dart';
import 'package:tul_entry_app/src/blocs/product_carts_bloc.dart';


class Provider extends InheritedWidget {

  final createProductBloc = CreateProductBloc();
  final cartBloc = CartBloc();
  final productCartsBloc = ProductCartsBloc();
  static Provider _instance;
  
  factory Provider({Key key, Widget child}){
    if(_instance == null){
      _instance = new Provider._internal(key: key, child: child);
    }
    return _instance;
  }
  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
  static CreateProductBloc of ( BuildContext context ){
   return context.dependOnInheritedWidgetOfExactType<Provider>().createProductBloc;
  }
  
  static CartBloc callCart ( BuildContext context ){
   return context.dependOnInheritedWidgetOfExactType<Provider>().cartBloc;
  }

  static ProductCartsBloc callProductCarts ( BuildContext context ){
   return context.dependOnInheritedWidgetOfExactType<Provider>().productCartsBloc;
  }

}