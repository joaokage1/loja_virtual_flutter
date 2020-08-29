import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {

  final String orderId;
  OrderScreen(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pedido Realizado",
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check,
            size: 80.0,
            color: Theme.of(context).primaryColor,),
            Text(
              "Pedido realizado com sucesso! Limite de 3 dias para o cancelamento",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Text(
              "Código do pedido: ${orderId}", style: TextStyle(
              fontSize: 16.0
            ),
            )
          ],
        ),
      ),
    );
  }
}
