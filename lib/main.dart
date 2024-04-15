import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om_e_comm/utils/route_utils.dart';
import 'package:om_e_comm/views/screens/cart_page.dart';
import 'package:om_e_comm/views/screens/checkout.dart';
import 'package:om_e_comm/views/screens/home.dart';
import 'package:om_e_comm/views/screens/login_page.dart';
import 'package:om_e_comm/views/screens/order_completed.dart';
import 'package:om_e_comm/views/screens/order_history.dart';
import 'package:om_e_comm/views/screens/pro_detail.dart';
import 'package:om_e_comm/views/screens/profile.dart';
import 'package:om_e_comm/views/screens/register_page.dart';
import 'package:om_e_comm/views/screens/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: MyRoutes.splash,
      getPages: [
        GetPage(name: MyRoutes.home, page: () => const HomePage()),
        GetPage(name: MyRoutes.cart, page: () => const CartPage()),
        GetPage(name: MyRoutes.checkout, page: () => const CheckOutPage()),
        GetPage(name: MyRoutes.login, page: () => LoginPage()),
        GetPage(name: MyRoutes.orderDone, page: () => const OrderCompleted()),
        GetPage(name: MyRoutes.orderHistory, page: () => const OrderHistory()),
        GetPage(name: MyRoutes.proDetail, page: () => const ProDetail()),
        GetPage(name: MyRoutes.profile, page: () => const ProfilePage()),
        GetPage(name: MyRoutes.register, page: () => const RegisterPage()),
        GetPage(name: MyRoutes.splash, page: () => const SplashScreen()),
      ],
    );
  }
}
