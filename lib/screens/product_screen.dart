import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/data/cart_product.dart';
import 'package:lojavirtualflutter/data/product_data.dart';
import 'package:lojavirtualflutter/models/cart_model.dart';
import 'package:lojavirtualflutter/models/user_model.dart';
import 'package:lojavirtualflutter/screens/cart_screen.dart';
import 'package:lojavirtualflutter/screens/login_screen.dart';

class ProductScreen extends StatefulWidget {
  final ProductData data;

  ProductScreen(this.data);

  @override
  _State createState() => _State(data);
}

class _State extends State<ProductScreen> {
  final ProductData data;

  _State(this.data);

  @override
  Widget build(BuildContext context) {
    final Color pc = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(data.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.0,
            child: Carousel(
              images: data.images.map((url) {
                return NetworkImage(url);
              }).toList(),
              dotSize: 10.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: pc,
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  data.title,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${data.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 22.0, fontWeight: FontWeight.bold, color: pc),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 46.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (UserModel.of(context).isLogIn()) {
                        CartProduct product = CartProduct();
                        product.quantity = 1;
                        product.pid = data.id;
                        product.category = data.category;
                        product.productData = data;

                        CartModel.of(context).addCartItem(product);

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CartScreen()));
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      }
                    },
                    child: Text(
                      UserModel.of(context).isLogIn()
                          ? "Acidionar ao Carrinho"
                          : "Entre ou Cadastre-se",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    color: pc,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Descrição",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                Text(
                  data.description,
                  style: TextStyle(fontSize: 16.0),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
