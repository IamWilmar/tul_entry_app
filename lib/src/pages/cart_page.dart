import 'package:flutter/material.dart';
import 'package:tul_entry_app/src/blocs/provider.dart';
import 'package:tul_entry_app/src/models/carts_model.dart';
import 'package:tul_entry_app/src/models/product_carts_model.dart';
import 'package:tul_entry_app/src/pages/edit_product_page.dart';
import 'package:tul_entry_app/src/providers/carts_provider.dart';
import 'package:tul_entry_app/src/providers/product_carts_provider.dart';

class ShoppingCartPage extends StatelessWidget {
  static final String routeName = "shoppingCardPage";
  @override
  Widget build(BuildContext context) {
    final CartsModel actualCart = ModalRoute.of(context).settings.arguments;
    final cartProvider = CartsProvider();
    final cartBloc = Provider.callCart(context);
    final blocproduct = Provider.callProductCarts(context);
    cartBloc.updateState(actualCart.status);
    blocproduct.updateQuantity(0);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFFA6C9B8),
        title: Text("Cart"),
        actions: [
          StreamBuilder(
              stream: cartBloc.statusStream,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                final status = snapshot.data;
                return RaisedButton.icon(
                  color: Color(0xFF558B71),
                  icon: Icon(Icons.done),
                  label: status == "pending"
                      ? Text("Buy order")
                      : Text("Completed"),
                  onPressed: status == "pending"
                      ? () {
                          cartProvider.editCartStatus(actualCart);
                          cartBloc.updateState(actualCart.status);
                          Navigator.pop(context);
                        }
                      : null,
                );
              }),
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
    final blocProductCart = Provider.callProductCarts(context);
    return StreamBuilder(
        stream: blocProductCart.quantityStream,
        builder: (context, snapshot) {
          return Container(
            child: FutureProductList(
                productsInCartProvider: productsInCartProvider,
                cartInfo: cartInfo),
          );
        });
  }
}

class FutureProductList extends StatelessWidget {
  const FutureProductList({
    Key key,
    @required this.productsInCartProvider,
    @required this.cartInfo,
  }) : super(key: key);

  final ProductsCartsProvider productsInCartProvider;
  final CartsModel cartInfo;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
        });
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
      onDismissed: currentCart.status == "pending" 
      ? (direction) {
        productCartProvider.deleteProductFromCart(productoInCart.id);
      }
      : null,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: currentCart.status == "pending" ? Color(0xFF558B71) : Color(0xFFB3D0C2),
        ),
        child: ListTile(
          title: FutureBuilder(
            future:
                productCartProvider.getProductName(productoInCart.productId),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return snapshot.hasData
                  ? Text(snapshot.data)
                  : Text("Waiting...");
            },
          ),
          subtitle: Text(productoInCart.quantity.toString()),
          enabled: currentCart.status == "pending" ? true : false,
          onTap: () {
            Navigator.pushNamed(context, EditProductPage.routeName,
                arguments: productoInCart);
          },
        ),
      ),
    );
  }
}

class QuantityNumber extends StatelessWidget {
  final String quantity;
  const QuantityNumber({@required this.quantity});
  @override
  Widget build(BuildContext context) {
    final blocProductCart = Provider.callProductCarts(context);
    return StreamBuilder(
      stream: blocProductCart.quantityStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: Text(quantity),
        );
      },
    );
  }
}
