import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lojavirtualflutter/data/cart_product.dart';
import 'package:lojavirtualflutter/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel user;
  List<CartProduct> products = [];

  bool isloading = false;

  String couponCode;
  int discountPercentage = 0;
  String address;

  CartModel(this.user){
    if(user.isLogIn()){
      _loadCartItems();
    }
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct product) {
    products.add(product);

    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .add(product.toMap())
        .then((doc) {
      product.cid = doc.documentID;
    });

    notifyListeners();
  }

  void removeCartItem(CartProduct product) {
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(product.cid)
        .delete();

    products.remove(product);

    notifyListeners();
  }

  void decProduct(CartProduct product) {
    product.quantity--;

    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(product.cid)
        .updateData(product.toMap());

    notifyListeners();
  }

  void incProduct(CartProduct product) {
    product.quantity++;

    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(product.cid)
        .updateData(product.toMap());

    notifyListeners();
  }

  void _loadCartItems() async {

    QuerySnapshot query = await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .getDocuments();

    products = query.documents.map((e) => CartProduct.fromDocument(e)).toList();

    notifyListeners();
  }

  void setCoupon(String couponCode, int discountPorcentage){
    this.couponCode = couponCode;
    this.discountPercentage = discountPorcentage;
  }

  void setAddress(String address){
    this.address = address;
  }

  void updatePrices(){
    notifyListeners();
  }

  double getProductPrice(){
    double price = 0.0;
    for(CartProduct c in products){
      if (c.productData!=null){
        price+= c.quantity * c.productData.price;
      }
    }

    return price;
  }
  double getShipPrice(){
    return 9.99;
  }
  double getDiscount(){
    return getProductPrice() * discountPercentage / 100;
  }

  Future<String> finishOrder() async{
    if(products.isEmpty) return null;

    isloading = true;
    notifyListeners();
    
    DocumentReference ref = await Firestore.instance.collection("orders").add({
      "clientId": user.firebaseUser.uid,
      "products": products.map((e) => e.toMap()).toList(),
      "address": address,
      "date": DateTime.now(),
      "shipPrice": getShipPrice(),
      "productsPrice": getProductPrice(),
      "discount": getDiscount(),
      "totalPrice": getProductPrice() + getShipPrice() - getDiscount(),
      "status": 1
    });

    await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("orders").document(ref.documentID).setData({
      "orderId": ref.documentID
    });

    QuerySnapshot querySnapshot = await Firestore.instance.collection("users")
        .document(user.firebaseUser.uid).collection("cart").getDocuments();

    for(DocumentSnapshot doc in querySnapshot.documents){
      doc.reference.delete();
    }

    products.clear();

    couponCode = null;
    discountPercentage = 0;

    isloading = false;
    notifyListeners();

    return ref.documentID;
  }
}
