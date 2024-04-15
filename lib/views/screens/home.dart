import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om_e_comm/helper/api_helper.dart';
import 'package:om_e_comm/helper/firebase_helper.dart';
import 'package:om_e_comm/modal/product_modal.dart';
import 'package:om_e_comm/utils/route_utils.dart';
import 'package:om_e_comm/views/component/drawer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: EdgeInsets.all(5),
        child: ElevatedButton(
          child: const Text("Add to Cart"),
          onPressed: () {},
        ),
      ),
      drawer: MyDrawer(),
      appBar: AppBar(
        title: const Text("Gleamrush"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                // ApiHelper.apiHelper.getData();
                Get.toNamed(MyRoutes.cart);
              },
              icon: const Icon(CupertinoIcons.cart)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: FutureBuilder(
            future: FirebaseHelper.firebaseHelper.getProduct(),
            builder: (context, snap) {
              if (snap.hasData) {
                Map pro = snap.data as Map;
                List tmpdata = pro['product'];
                List<Product> data = tmpdata.map((e) {
                  return Product.fromMap(data: e);
                }).toList();
                return GridView.builder(
                    itemCount: data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 2 / 3),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(MyRoutes.proDetail,
                              arguments: data[index]);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.network(data[index].image, height: 170),
                              Text(
                                data[index].title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(data[index].description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 12)),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text("₹ ${data[index].price}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                  ),
                                  Text(
                                    "${data[index].rating['rate']} 🌟",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else if (snap.hasError) {
                log(snap.error.toString());
                return Center(
                  child: Text(
                    snap.error.toString(),
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                );
              } else {
                return Skeletonizer(
                  enabled: true,
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) => Container(
                            child: Column(
                              children: [
                                Image.network(
                                    "https://cdn.vox-cdn.com/thumbor/ln4IHgPYpvNoIWpJ2Y1_c9msxXA=/0x0:2012x1341/2000x1333/filters:focal(1006x670:1007x671)/cdn.vox-cdn.com/uploads/chorus_asset/file/15483559/google2.0.0.1441125613.jpg",
                                    height: 100),
                                const Text("sdfgrerghedrg"),
                                const Text("esfgrg"),
                                const Text("fvnobgn fghsiji"),
                              ],
                            ),
                          )),
                );
              }
            }),
      ),
    );
  }
}
