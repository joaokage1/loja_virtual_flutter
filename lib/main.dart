import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/models/cart_model.dart';
import 'package:lojavirtualflutter/models/user_model.dart';
import 'package:lojavirtualflutter/screens/login_screen.dart';
import 'package:lojavirtualflutter/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          return ScopedModel<CartModel>(
            model: CartModel(model),
            child:  MaterialApp(
                title: 'Flutter Clothing',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  primaryColor: Color.fromARGB(255, 153, 0, 204),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                debugShowCheckedModeBanner: false,
                home: HomeScreen()
            ),
          );
        },
      )
    );
  }
}

