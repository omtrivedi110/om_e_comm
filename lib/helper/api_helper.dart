import 'dart:convert';
import 'package:http/http.dart' as http;
import '../modal/product_modal.dart';
import 'firebase_helper.dart';

class ApiHelper {
  ApiHelper._();
  static final ApiHelper apiHelper = ApiHelper._();

  Future getData() async {
    http.Response response =
        await http.get(Uri.parse("https://fakestoreapi.com/products"));
    List data = jsonDecode(response.body);
    FirebaseHelper.firebaseHelper.addProduct(product: data);
    List<Product> data2 = data.map((e) {
      return Product.fromMap(data: e);
    }).toList();
    return data2;
  }
}
