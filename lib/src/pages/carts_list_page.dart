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
        backgroundColor: Color(0xFFA6C9B8),
        elevation: 0.0,
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
          return FutureListWidget(cartProvider: cartProvider);
        }
      ),
    );
  }
}

class FutureListWidget extends StatelessWidget {
  const FutureListWidget({
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
              return CartsTile(cart: carts[(carts.length-1)-index]);
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
    return Container(
      padding: EdgeInsets.symmetric(vertical:20.0),
      margin: EdgeInsets.symmetric(vertical:3.0, horizontal:5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: cart.status == "pending" ? Color(0xFF5D987B): Color(0xFFB3D0C2),
      ),
      child: ListTile(
        title: cart.status == "pending" ? Text("Carrito Actual") : Text("Compra realizada"),
        subtitle: Text(cart.status),
        onTap: (){
          Navigator.pushNamed(context, ShoppingCartPage.routeName, arguments: cart);
        },
      ),
    );
  }
}