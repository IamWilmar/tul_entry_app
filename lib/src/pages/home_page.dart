import 'package:flutter/material.dart';
import 'package:tul_entry_app/src/models/product_model.dart';
import 'package:tul_entry_app/src/pages/carts_list_page.dart';
import 'package:tul_entry_app/src/providers/productos_provider.dart';
import 'package:tul_entry_app/src/widgets/product_tile.dart';

class HomePage extends StatelessWidget {
  static final String routeName = "homePage";
  final TextStyle appBarTitle = TextStyle(color: Colors.black);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text("Tul Products", style: appBarTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, CartListPage.routeName);
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          WelcomeBanner(
            welcomeMessage: "Bienvenido a Tül",
            subMessage: "Encuentra los productos que necesitas",
          ),
          SeparationBar(),
          ProductList(),
        ],
      ),
    );
  }
}


class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productosProvider = ProductosProvider();
    return Container(
      child: FutureBuilder(
          future: productosProvider.cargarProductos(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ProductModel>> snapshot) {
            if (snapshot.hasData) {
              final productos = snapshot.data;
              return CustomProductGrid(productList: productos);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
