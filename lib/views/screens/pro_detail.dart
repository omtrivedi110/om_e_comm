import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om_e_comm/helper/firebase_helper.dart';
import 'package:om_e_comm/modal/product_modal.dart';

import '../../utils/route_utils.dart';

class ProDetail extends StatefulWidget {
  const ProDetail({super.key});

  @override
  State<ProDetail> createState() => _ProDetailState();
}

class _ProDetailState extends State<ProDetail> {
  Product data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      bottomSheet: BottomSheet(
        builder: (context) {
          return GestureDetector(
            onTap: () async {
              await FirebaseHelper.firebaseHelper.addToCart(data: data);
              Get.toNamed(MyRoutes.cart);
            },
            child: Container(
                height: s.height * 0.05,
                padding: const EdgeInsets.only(left: 5, right: 5),
                width: double.infinity,
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: Colors.blue),
                child: const Text(
                  "Added to cart",
                  style: TextStyle(fontSize: 18),
                )),
          );
        },
        onClosing: () {},
      ),
      appBar: AppBar(
        title: Text(data.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            InteractiveViewer(
                child: Image.network(
              data.image,
              height: s.height * 0.5,
            )),
            const SizedBox(
              height: 10,
            ),
            Text(data.title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: Text("₹ ${data.price}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400))),
                Text(
                  "${data.rating['rate']} 🌟",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Category : ${data.category}",
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                )),
                Text(
                  "Last ${data.rating['count']} Items Left",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Description:",
              style: TextStyle(fontSize: 17),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(data.description,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4)),
            SizedBox(height: s.height * 0.05)
          ],
        ),
      ),
    );
  }
}
