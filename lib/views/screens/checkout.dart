import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om_e_comm/utils/route_utils.dart';

import '../../helper/firebase_helper.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  bool isOne = false;
  Map<String, dynamic> data = {};
  List cart = [];
  double price = 0;
  double percentage = 0;

  TextEditingController promoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart Page"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: FutureBuilder(
          future: FirebaseHelper.firebaseHelper.getCart(),
          builder: (context, snap) {
            if (snap.hasData) {
              if (!isOne) {
                data = snap.data as Map<String, dynamic>;
                cart = data['products'];
                isOne = true;
                price = data['price'];
              }
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: s.height * 0.104 * cart.length,
                      child: ListView.separated(
                        itemCount: cart.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          return Container(
                            height: s.height * 0.09,
                            decoration: const BoxDecoration(),
                            child: Row(
                              children: [
                                Image.network(
                                  "${cart[index]['image']}",
                                  height: s.height * 0.09,
                                  width: s.width * 0.2,
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                    width: s.width * 0.6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text((cart[index]['title']),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                const TextStyle(fontSize: 16)),
                                        Text(
                                            "₹ ${(double.parse(cart[index]['price'].toString()) * double.parse(cart[index]['qty'].toString()))}"),
                                        Row(
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  if (int.parse(cart[index]
                                                              ['qty']
                                                          .toString()) !=
                                                      1) {
                                                    cart[index]['qty'] =
                                                        int.parse(cart[index]
                                                                    ['qty']
                                                                .toString()) -
                                                            1;
                                                    price -= double.parse(
                                                        cart[index]['price']
                                                            .toString());
                                                  } else {
                                                    price -= (double.parse(
                                                            cart[index]['price']
                                                                .toString()) *
                                                        double.parse(cart[index]
                                                                ['qty']
                                                            .toString()));
                                                    cart.removeAt(index);
                                                  }
                                                  setState(() {});
                                                },
                                                child:
                                                    const Icon(Icons.remove)),
                                            const SizedBox(width: 9),
                                            Text(cart[index]['qty'].toString()),
                                            const SizedBox(width: 9),
                                            GestureDetector(
                                                onTap: () {
                                                  cart[index]['qty'] =
                                                      int.parse(cart[index]
                                                                  ['qty']
                                                              .toString()) +
                                                          1;
                                                  price += double.parse(
                                                      cart[index]['price']
                                                          .toString());
                                                  setState(() {});
                                                },
                                                child: const Icon(Icons.add))
                                          ],
                                        )
                                      ],
                                    )),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {
                                      price -= (double.parse(
                                              cart[index]['price'].toString()) *
                                          double.parse(
                                              cart[index]['qty'].toString()));
                                      cart.removeAt(index);
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.delete_simple,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: s.height * 0.015),
                    TextFormField(
                      readOnly: true,
                      controller: promoController,
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return FutureBuilder(
                                  future: FirebaseHelper.firebaseHelper
                                      .getPromoCode(),
                                  builder: (context, snap) {
                                    if (snap.hasError) {
                                      return Center(
                                          child: Text(snap.error.toString()));
                                    } else if (snap.hasData) {
                                      Map<String, dynamic> pro =
                                          snap.data as Map<String, dynamic>;
                                      List promocode = pro['code']['code'];
                                      List perc = pro['code']['perc'];
                                      return Column(
                                        children: [
                                          const SizedBox(height: 20),
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "All PromoCode",
                                                style: TextStyle(fontSize: 18),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          Expanded(
                                            child: ListView.builder(
                                                itemCount: promocode.length,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      promoController.text =
                                                          promocode[index]
                                                              ['code'];
                                                      price -= price *
                                                          double.parse(
                                                              perc[index]) /
                                                          100;
                                                      percentage = double.parse(
                                                          perc[index]
                                                              .toString());
                                                      setState(() {});
                                                    },
                                                    title: Text(promocode[index]
                                                        ['code']),
                                                    subtitle: Text(
                                                        "${perc[index]} % off"),
                                                  );
                                                }),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                  });
                            });
                      },
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Enter PromoCode",
                          suffixIcon: promoController.text == ""
                              ? null
                              : GestureDetector(
                                  onTap: () {
                                    promoController.clear();
                                    price += price * percentage / 100;
                                    percentage = 0;
                                    setState(() {});
                                  },
                                  child: const Icon(CupertinoIcons.delete)),
                          labelText: "PromoCode"),
                    ),
                    SizedBox(height: s.height * 0.015),
                    Row(
                      children: [
                        Text(
                          "Total : ${price.toString().split('.')[0]}",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        await FirebaseHelper.firebaseHelper
                            .addCheckout(product: data);
                        Get.offAllNamed(MyRoutes.home);
                      },
                      child: Container(
                          height: s.height * 0.05,
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: const Text("Complete Order",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white))),
                    )
                  ],
                ),
              );
            } else if (snap.hasError) {
              return Center(child: Text(snap.error.toString()));
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
