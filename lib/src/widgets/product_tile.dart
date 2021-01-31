import 'package:flutter/material.dart';
import 'package:tul_entry_app/src/models/product_model.dart';
import 'package:tul_entry_app/src/pages/product_page.dart';

class CustomProductGrid extends StatelessWidget {
  final List<ProductModel> productList;
  const CustomProductGrid({Key key, this.productList});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: GridView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: productList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.82,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (BuildContext context, int index) {
          return productList.length != 0
              ? CustomProductTile(product: productList[index])
              : Container();
        },
      ),
    );
  }
}

class CustomProductTile extends StatelessWidget {
  final ProductModel product;
  const CustomProductTile({@required this.product});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, ProductPage.routeName, arguments: product);
      },
      child: Container(
        margin: EdgeInsets.all(5.0),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Color(0xFFA6C9B8),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 2.0,
              spreadRadius: 0.1,
              offset: Offset(2.0, 1.0),
            ),
          ],
        ),
        child: ProductTileContent(product: product),
      ),
    );
  }
}



class WelcomeBanner extends StatelessWidget {
  final TextStyle welcomeMessageStyle = TextStyle(fontSize:50.0, letterSpacing: 1.5, fontWeight: FontWeight.w600);
  final TextStyle subMessageStyle = TextStyle(fontSize:20.0, letterSpacing: 1.5, fontWeight: FontWeight.w300, color: Colors.grey[400]);
  final String welcomeMessage;
  final String subMessage;
  WelcomeBanner({@required this.welcomeMessage, @required this.subMessage});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(welcomeMessage, style: welcomeMessageStyle),
          Text(subMessage, style: subMessageStyle),
        ],
      ),
    );
  }
}


class ProductTileContent extends StatelessWidget {
  final ProductModel product;
  final TextStyle nameStyle = TextStyle(fontSize: 25.0, letterSpacing: 1.5, fontWeight: FontWeight.w900);
    final TextStyle descStyle = TextStyle(fontSize: 15.0, letterSpacing: 1.5, fontWeight: FontWeight.w300);

  ProductTileContent({@required this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.nombre, style: nameStyle),
          SizedBox(height: 20.0,),
          Text(product.descripcion, style: descStyle),
        ],
      ),
    );
  }
}

class SeparationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15, left: 20.0, right: 13.0),
      height: 5.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.grey[400],
      ),
    );
  }
}