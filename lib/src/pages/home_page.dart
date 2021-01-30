import 'package:flutter/material.dart';
import 'package:tul_entry_app/src/models/product_model.dart';
import 'package:tul_entry_app/src/pages/create_product_page.dart';
import 'package:tul_entry_app/src/pages/product_page.dart';
import 'package:tul_entry_app/src/providers/productos_provider.dart';


class HomePage extends StatelessWidget {
  static final String routeName = "homePage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tul Products"),
      ),
      body: ProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, CreateProductPage.routeName);
        },
        child: Icon(Icons.add),
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
        builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot){
          if(snapshot.hasData){
            final productos = snapshot.data;
            return ListView.builder(
              itemCount: productos.length,
              itemBuilder: (BuildContext context, int index ){
                return ProductTile(producto: productos[index]);
              },
            );
          }else{
            return CircularProgressIndicator();
          }
        }
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final ProductModel producto;
  const ProductTile({this.producto});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(producto.nombre),
      subtitle: Text(producto.id),
      onTap: (){
        Navigator.pushNamed(context, ProductPage.routeName, arguments: producto);
      },
    );
  }
}