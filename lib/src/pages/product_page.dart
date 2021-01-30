import 'package:flutter/material.dart';
import 'package:tul_entry_app/src/blocs/provider.dart';
import 'package:tul_entry_app/src/models/product_model.dart';

class ProductPage extends StatelessWidget {
  static final String routeName = "ProductPage";
  @override
  Widget build(BuildContext context) {
    final ProductModel product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.id),
      ),
      body: SingleChildScrollView(
        child: ProductContent(product: product),
      ),
    );
  }
}

class ProductContent extends StatelessWidget {
  final ProductModel product;
  final TextStyle productNameStyle = TextStyle(
    fontSize: 40.0,
    letterSpacing: 1.5,
    fontWeight: FontWeight.w600,
  );
  final TextStyle skuStyle = TextStyle(
      fontSize: 20.0,
      letterSpacing: 1.5,
      fontWeight: FontWeight.w600,
      color: Colors.grey[400]);
  ProductContent({@required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              maxRadius: 100,
            ),
          ),
          SizedBox(height: 10.0),
          Text(product.nombre, style: productNameStyle),
          Text(product.sku, style: skuStyle),
          SeparationLine(),
          Text(product.descripcion, textAlign: TextAlign.justify),
          SeparationLine(),
          CartSection(),
        ],
      ),
    );
  }
}

class SeparationLine extends StatelessWidget {
  const SeparationLine({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      height: 3.0,
      color: Colors.black45,
    );
  }
}

class CartSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.callProductCarts(context);
    return StreamBuilder(
      stream: bloc.quantityStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: Row(
            children: [
              Container(
                width: 50,
                child: TextFormField(
                  decoration: InputDecoration(
                    counterText: bloc.quantity.toString(),
                  ),
                  onChanged: (val) {bloc.updateQuantity(int.parse(val));},
                ),

              ),
              CartButton(),
            ],
          ),
        );
      }
    );
  }
}

class CartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(Icons.shopping_cart, size: 50.0),
        onPressed: (){},
      ),
    );
  }
}
