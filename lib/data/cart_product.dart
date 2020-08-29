import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojavirtualflutter/data/product_data.dart';

class CartProduct {

  String cid;
  String category;
  String pid;

  int quantity;

  ProductData productData;

  CartProduct.fromDocument(DocumentSnapshot documentSnapshot){
    cid = documentSnapshot.documentID;
    category = documentSnapshot.data["category"];
    quantity = documentSnapshot["quantity"];
    pid = documentSnapshot.data["pid"];
  }

  CartProduct();

  Map<String, dynamic> toMap(){
    return {
      "category": category,
      "pid": pid,
      "quantity": quantity,
      "product": productData.toResumedMap()
    };
  }
}