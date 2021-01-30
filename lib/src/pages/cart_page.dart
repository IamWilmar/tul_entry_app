import 'package:flutter/material.dart';
import 'package:tul_entry_app/src/models/carts_model.dart';

class ShoppingCartPage extends StatelessWidget {
  static final String routeName = "shoppingCardPage";
  @override
  Widget build(BuildContext context) {
    final CartsModel actualCart = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(actualCart.id),
      ),
    );
  }
}
