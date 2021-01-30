import 'package:flutter/material.dart';
import 'package:tul_entry_app/src/models/carts_model.dart';
import 'package:tul_entry_app/src/pages/cart_page.dart';
import 'package:tul_entry_app/src/providers/carts_provider.dart';


class CartListPage extends StatelessWidget {
  static final String routeName = "cartPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart List"),
      ),
      body: CartListWidget(),
   );
  }
}


class CartListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final cartProvider = CartsProvider();
    return Container(
      child: FutureBuilder(
        future: cartProvider.getAllCarts(),
        builder: (BuildContext context, AsyncSnapshot<List<CartsModel>> snapshot){
          if(snapshot.hasData){
            final carts = snapshot.data;
            return ListView.builder(
              itemCount: carts.length,
              itemBuilder: (BuildContext context, int index ){
                return CartsTile(cart: carts[index]);
              },
            );
          }else{
            return Center(child:CircularProgressIndicator());
          }
        }
      ),
    );
  }
}

class CartsTile extends StatelessWidget {
  final CartsModel cart;
  const CartsTile({this.cart});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(cart.id),
      subtitle: Text(cart.status),
      onTap: (){
        Navigator.pushNamed(context, ShoppingCartPage.routeName, arguments: cart);
      },
    );
  }
}