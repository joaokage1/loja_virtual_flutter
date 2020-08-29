import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/screens/tabs/orders_tab.dart';
import 'package:lojavirtualflutter/screens/tabs/places_tab.dart';
import 'package:lojavirtualflutter/screens/tabs/products_tab.dart';
import 'package:lojavirtualflutter/widgets/cart_button.dart';
import 'package:lojavirtualflutter/widgets/custom_drawer.dart';

import 'tabs/home_tab.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Contato"),
            centerTitle: true,
          ),
          body: PlacesTab(),

          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Meus Pedidos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: OrdersTab(),
        )
      ],
    );
  }
}
