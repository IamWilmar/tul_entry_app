import 'package:flutter/material.dart';
import 'package:tul_entry_app/src/blocs/provider.dart';
import 'package:tul_entry_app/src/pages/cart_page.dart';
import 'package:tul_entry_app/src/pages/carts_list_page.dart';
import 'package:tul_entry_app/src/pages/create_product_page.dart';
import 'package:tul_entry_app/src/pages/home_page.dart';
import 'package:tul_entry_app/src/pages/product_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tul Entry',
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName          : (BuildContext context) => HomePage(),
          ProductPage.routeName       : (BuildContext context) => ProductPage(),
          CreateProductPage.routeName : (BuildContext context) => CreateProductPage(),
          CartListPage.routeName      : (BuildContext context) => CartListPage(),
          ShoppingCartPage.routeName  : (BuildContext context) => ShoppingCartPage()
        },
      ),
    );
  }
}