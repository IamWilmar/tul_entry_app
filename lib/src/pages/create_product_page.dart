import 'package:flutter/material.dart';
import 'package:tul_entry_app/src/blocs/create_product_bloc.dart';
import 'package:tul_entry_app/src/blocs/provider.dart';
import 'package:tul_entry_app/src/models/product_model.dart';
import 'package:tul_entry_app/src/providers/productos_provider.dart';

class CreateProductPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  static final String routeName = "CreateProductPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CrearNombre(),
              CrearSKu(),
              CrearDescripcion(),
              Boton(),
            ],
          ),
        ),
      ),
    );
  }
}

class CrearNombre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return StreamBuilder(
      stream: bloc.nombreStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Nombre",
              errorText: snapshot.error,
            ),
            onChanged: bloc.cambiarNombre,
          ),
        );
      },
    );
  }
}

class CrearSKu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return StreamBuilder(
      stream: bloc.skuStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Sku",
              errorText: snapshot.error,
            ),
            onChanged: bloc.cambiarSku,
          ),
        );
      },
    );
  }
}

class CrearDescripcion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return StreamBuilder(
      stream: bloc.descripcionStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Descripcion",
              errorText: snapshot.error,
            ),
            onChanged: bloc.cambiarDescripcion,
          ),
        );
      },
    );
  }
}

class Boton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return StreamBuilder(
      stream: bloc.camposLlenos,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: RaisedButton.icon(
            label: Text("Save"),
            icon: Icon(Icons.save),
            onPressed: snapshot.hasData ? () =>_saveProduct(context, bloc) : null,
          ),
        );
      }
    );
  }

  _saveProduct(BuildContext context, CreateProductBloc bloc){
    final productProvider = ProductosProvider();
    ProductModel productoNuevo = new ProductModel(
      nombre      : bloc.nombreProducto,
      sku         : bloc.skuProducto,
      descripcion : bloc.descripcionProducto,
    );
    productProvider.crearProducto(productoNuevo);
    Navigator.pop(context);
  }

}
