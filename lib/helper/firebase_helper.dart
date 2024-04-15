import 'package:cloud_firestore/cloud_firestore.dart';

import '../modal/product_modal.dart';

class FirebaseHelper {
  FirebaseHelper._();
  static final FirebaseHelper firebaseHelper = FirebaseHelper._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //product
  String collection = "product";
  String idCollection = "id";
  String doc = "product";
  String idDoc = "id";

  //cart
  String cartCollection = "cart";
  String cartDoc = "cart";

  //promocode
  String promoCollection = "promocode";
  String promoDoc = "codes";

  //checkout
  String checkCollection = "checkout";
  String checkDoc = "checkout";

  getProduct() async {
    DocumentSnapshot<Map<String, dynamic>> document =
        await firestore.collection('product').doc('product').get();
    return document.data() as Map;
  }

  getPromoCode() async {
    DocumentSnapshot<Map<String, dynamic>> document =
        await firestore.collection(promoCollection).doc(promoDoc).get();
    return document.data() as Map;
  }

  addProduct({required List product}) {
    firestore.collection('product').doc('product').set({'product': product});
  }

  addCheckout({required Map<String, dynamic> product}) async {
    await firestore.collection(checkCollection).doc(checkDoc).set(product);
  }

  Future<void> addToCart({required Product data}) async {
    Map<String, dynamic> oldCart = await getCart();
    // List csd= [];
    // csd.e(data.toMap());
    bool contain = false;
    int index = -1;
    oldCart['products'].forEach((element) {
      if (element['id'] == data.id) {
        contain = true;
        index = oldCart['products'].indexOf(element);
      }
    });
    // if()
    contain
        // oldCart['products'].contains(data.toMap())
        ? oldCart['products'][index]['qty'] =
            int.parse(oldCart['products'][index]['qty'].toString()) + 1
        : oldCart['products'].add(data.toMap());
    oldCart['price'] = double.parse(
            oldCart['price'] == null || oldCart['price'] == ""
                ? "0"
                : oldCart['price'].toString()) +
        data.price;
    await firestore.collection(cartCollection).doc(cartDoc).set(oldCart);
  }

  Future<Map<String, dynamic>> getCart() async {
    DocumentSnapshot<Map<String, dynamic>> document =
        await firestore.collection(cartCollection).doc(cartDoc).get();

    return document.data() as Map<String, dynamic>;
  }

  addId() async {
    DocumentSnapshot<Map<String, dynamic>> document =
        await firestore.collection(idCollection).doc(idDoc).get();
    Map data = document.data() as Map;
    int id = int.parse(data['id'].toString());
    id += 1;
    firestore.collection(idCollection).doc(idDoc).set({"id": id});
  }
}
