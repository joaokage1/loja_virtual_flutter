import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderTile extends StatelessWidget {
  final String orderId;

  OrderTile(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection("orders")
              .document(orderId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            int status = snapshot.data["status"];
            String transporte = snapshot.data["address"];
            bool retirar = false;
            if (transporte == null || transporte.contains("retirar") || transporte.contains("Retirar")){
              retirar = true;
            }
            if (retirar){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Código do pedido: ${snapshot.data.documentID}",
                    style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 6.0,),
                  Text(
                      _buildProductText(snapshot.data)
                  ),
                  SizedBox(height: 6.0,),
                  Text("Status do Pedido: ",
                    style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 6.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCircle("1", "Preparação", status, 1),
                      Container(
                        height: 1.0,
                        width: 40.0,
                        color: Colors.grey[500],
                      ),
                      _buildCircle("2", "Retirado", status, 2)
                    ],
                  )
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Código do pedido: ${snapshot.data.documentID}",
                  style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 6.0,),
                Text(
                    _buildProductText(snapshot.data)
                ),
                SizedBox(height: 6.0,),
                Text("Status do Pedido: ",
                  style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 6.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCircle("1", "Preparação", status, 1),
                    Container(
                      height: 1.0,
                      width: 40.0,
                      color: Colors.grey[500],
                    ),
                    _buildCircle("2", "Transporte", status, 2),
                    Container(
                      height: 1.0,
                      width: 40.0,
                      color: Colors.grey[500],
                    ),
                    _buildCircle("3", "Entregue", status, 3)
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

  String _buildProductText(DocumentSnapshot snapshot){
    String text = "Descrição: \n";

    Timestamp timeStamp = snapshot.data["date"];
    var date = DateTime.fromMicrosecondsSinceEpoch(timeStamp.microsecondsSinceEpoch);
    final df = new DateFormat('dd/MM/yyyy hh:mm');
    text += "Data: "+ df.format(date.toLocal()) + "\n";
    for(LinkedHashMap p in snapshot.data["products"]){
      text += "${p["quantity"]} x ${p["product"]["title"]} R\$ ${p["product"]["price"].toStringAsFixed(2)} \n";
    }

    if(snapshot.data["address"] == null){
      text += "Retirar com Vendedor \n";
    }else {
      text += "${snapshot.data["address"]} \n";
    }
    text += "Total: R\$ ${snapshot.data["totalPrice"].toStringAsFixed(2)}";
    return text;
  }

  Widget _buildCircle(String title, String subTitle, int status, thisStatus){

    Color backColor;
    Widget child;

    if (status < thisStatus){
      backColor = Colors.grey[500];
      child = Text(title, style: TextStyle(color: Colors.white),);
    } else if (status == thisStatus){
      backColor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: [
          Text(title, style: TextStyle(color: Colors.white),),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      );
    } else if(status == 5){
      backColor = Colors.red;
      child = Icon(Icons.close);
    } else {
        backColor = Colors.green;
        child = Icon(Icons.check);
    }

    return Column(
      children: [
        CircleAvatar(
          radius: 20.0,
          backgroundColor: backColor,
          child: child,
        ),
        Text(subTitle)
      ],
    );
  }
}
