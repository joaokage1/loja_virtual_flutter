import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTile extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;

  PlaceTile(this.documentSnapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 130.0,
            child: Image.network(
              documentSnapshot.data["image"],
              fit: BoxFit.cover,
              scale: 1.0,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  documentSnapshot.data["title"],
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17.0
                  ),
                ),
                Text(
                  documentSnapshot.data["address"],
                  textAlign: TextAlign.start,
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                child: Text(
                  "Ver no Mapa"
                ),
                textColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.zero,
                onPressed: (){
                  launch("https://www.google.com/maps/search/?api=1&query=${documentSnapshot.data["lat"]},"
                      "${documentSnapshot.data["long"]}");
                },
              ),
              FlatButton(
                child: Text(
                    "Ligar"
                ),
                textColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.zero,
                onPressed: (){
                  launch("tel: ${documentSnapshot.data["phone"]}");
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
