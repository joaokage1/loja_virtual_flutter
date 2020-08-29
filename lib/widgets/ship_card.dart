import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/models/cart_model.dart';

class ShipCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text(
          "Endereço",
          textAlign: TextAlign.start,
          style:
          TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
        ),
        leading: Icon(Icons.location_on),
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Rua/nº/Complemento ou Retirar"),
              initialValue: CartModel.of(context).address ?? "",
              onFieldSubmitted: (text) {
                CartModel.of(context).setAddress(text);
              },
            ),
          )
        ],
      ),
    );
  }
}
