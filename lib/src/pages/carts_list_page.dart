import 'package:flutter/material.dart';
import 'package:tul_entry_app/src/blocs/provider.dart';
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
    final cartBloc = Provider.callCart(context);
    return Container(
      child: StreamBuilder(
        stream: cartBloc.statusStream,
        builder: (context, snapshot) {
          return FutireListWidget(cartProvider: cartProvider);
        }
      ),
    );
  }
}

class FutireListWidget extends StatelessWidget {
  const FutireListWidget({
    Key key,
    @required this.cartProvider,
  }) : super(key: key);

  final CartsProvider cartProvider;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
    );
  }
}

class CartsTile extends StatelessWidget {
  final CartsModel cart;
  const CartsTile({this.cart});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: cart.status == "pending" ? Text("Carrito Actual") : Text("Compra realizada"),
      subtitle: Text(cart.status),
      onTap: (){
        Navigator.pushNamed(context, ShoppingCartPage.routeName, arguments: cart);
      },
    );
  }
}