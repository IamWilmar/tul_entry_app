import 'package:flutter/material.dart';
import 'package:tul_entry_app/src/blocs/provider.dart';
import 'package:tul_entry_app/src/models/carts_model.dart';
import 'package:tul_entry_app/src/models/product_carts_model.dart';
import 'package:tul_entry_app/src/providers/carts_provider.dart';
import 'package:tul_entry_app/src/providers/product_carts_provider.dart';

class ShoppingCartPage extends StatelessWidget {
  static final String routeName = "shoppingCardPage";
  @override
  Widget build(BuildContext context) {
    final CartsModel actualCart = ModalRoute.of(context).settings.arguments;
    final cartProvider = CartsProvider();
    final cartBloc = Provider.callCart(context);
    cartBloc.updateState(actualCart.status);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        actions: [
          StreamBuilder(
            stream: cartBloc.statusStream,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              final status = snapshot.data;
              return RaisedButton.icon(
                icon: Icon(Icons.done),
                label: status == "pending" ? Text("Buy order") : Text("Completed"),
                onPressed: status == "pending"
                ?(){
                  cartProvider.editCartStatus(actualCart);
                  cartBloc.updateState(actualCart.status);
                  }
                : null,
              );
            }
          ),
        ],
      ),
      body: ProductsInCartList(cartInfo: actualCart),
    );
  }
}

class ProductsInCartList extends StatelessWidget {
  final CartsModel cartInfo;
  const ProductsInCartList({@required this.cartInfo});
  @override
  Widget build(BuildContext context) {
    final productsInCartProvider = ProductsCartsProvider();
    return Container(
      child: FutureBuilder(
          future: productsInCartProvider.cargarProductos(cartInfo.id),
          builder: (BuildContext context,
              AsyncSnapshot<List<ProductCartsModel>> snapshot) {
            if (snapshot.hasData) {
              final productosinCart = snapshot.data;
              return ListView.builder(
                itemCount: productosinCart.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProductCartTile(
                    productoInCart: productosinCart[index],
                    currentCart: cartInfo,
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class ProductCartTile extends StatelessWidget {
  final ProductCartsModel productoInCart;
  final CartsModel currentCart;
  const ProductCartTile(
      {@required this.productoInCart, @required this.currentCart});
  @override
  Widget build(BuildContext context) {
    final productCartProvider = ProductsCartsProvider();
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction){
        productCartProvider.deleteProductFromCart(productoInCart.id);
      },
      child: ListTile(
        title: FutureBuilder(
          future: productCartProvider.getProductName(productoInCart.productId),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot){
            return snapshot.hasData ? Text(snapshot.data) : Text("Waiting..."); 
          },
        ),
        subtitle: Text(productoInCart.quantity.toString()),
        enabled: currentCart.status == "pending" ? true : false,
        onTap: () {
          //Navigator.pushNamed(context, ProductPage.routeName, arguments: producto);
        },
      ),
    );
  }
}
