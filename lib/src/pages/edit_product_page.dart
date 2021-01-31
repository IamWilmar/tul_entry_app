import 'package:flutter/material.dart';
import 'package:tul_entry_app/src/blocs/provider.dart';
import 'package:tul_entry_app/src/models/product_carts_model.dart';
import 'package:tul_entry_app/src/providers/product_carts_provider.dart';

class EditProductPage extends StatelessWidget {
  static final String routeName = "EditProductInCartPage";
  @override
  Widget build(BuildContext context) {
    final ProductCartsModel productInCart =
        ModalRoute.of(context).settings.arguments;
    final blocProductCart = Provider.callProductCarts(context);
    blocProductCart.updateProduct(productInCart);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: ProductInCartInfo(product: productInCart),
      ),
    );
  }
}

class ProductInCartInfo extends StatelessWidget {
  final ProductCartsModel product;
  const ProductInCartInfo({@required this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Column(
        children: [
          ProductName(product: product),
          Container(
            width: 100,
            child: Quantity(),
          ),
          UpdateButton(product: product),
        ],
      ),
    );
  }
}

class Quantity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final blocProductCart = Provider.callProductCarts(context);
    return Container(
      child: StreamBuilder(
        stream: blocProductCart.quantityStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            child: TextFormField(
              initialValue: blocProductCart.quantity.toString(),
              onChanged: (val) {
                blocProductCart.updateQuantity(int.parse(val));
              },
            ),
          );
        },
      ),
    );
  }
}

class UpdateButton extends StatelessWidget {
  final ProductCartsModel product;
  const UpdateButton({@required this.product});
  @override
  Widget build(BuildContext context) {
    final productCartProvider = ProductsCartsProvider();
    final blocProductCart = Provider.callProductCarts(context);
    return StreamBuilder(
      stream: blocProductCart.quantityStream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return RaisedButton.icon(
          icon: Icon(Icons.save),
          label: Text("Update Item"),
          onPressed: () {
            final model = new ProductCartsModel(
              id: product.id,
              cartId: product.cartId,
              productId: product.productId,
              quantity: blocProductCart.quantity
            );
            productCartProvider.updateProductFromCart(model);
            blocProductCart.updateQuantity(0);
            Navigator.pop(context);
          },
        );
      },
    );
  }
}

class ProductName extends StatelessWidget {
  final ProductCartsModel product;
  const ProductName({@required this.product});
  @override
  Widget build(BuildContext context) {
    final ProductsCartsProvider productCartProvider = ProductsCartsProvider();
    return FutureBuilder(
      future: productCartProvider.getProductName(product.productId),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return snapshot.hasData ? Text(snapshot.data) : Text("Waiting...");
      },
    );
  }
}
