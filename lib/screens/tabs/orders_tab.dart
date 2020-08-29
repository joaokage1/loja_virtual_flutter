
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/models/user_model.dart';
import 'package:lojavirtualflutter/screens/login_screen.dart';
import 'package:lojavirtualflutter/tiles/order_tile.dart';

class OrdersTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    UserModel user = UserModel.of(context);

    if(user.isLogIn()){

      String uid = user.firebaseUser.uid;
      return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("users").document(uid)
        .collection("orders").getDocuments(),
        builder: (context, snapshot){
          if (!snapshot.hasData){
            return CircularProgressIndicator();
          }
          return ListView(
            children: snapshot.data.documents.map((e) => OrderTile(e.documentID)).toList().reversed.toList(),
          );
        },
      );

    } else {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.playlist_add,
              size: 80.0,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              "Faça o login para visualizar pedidos",
              style:
              TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16.0,
            ),
            RaisedButton(
              child: Text(
                "Entrar",
                style: TextStyle(fontSize: 18.0),
              ),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LoginScreen()));
              },
            )
          ],
        ),
      );
    }

    return Container();
  }
}
