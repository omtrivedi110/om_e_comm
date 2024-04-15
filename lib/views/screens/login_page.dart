import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:om_e_comm/helper/firebase_helper.dart';
import 'package:om_e_comm/utils/route_utils.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Login Page",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Image.asset(
                'asset/images/Logo.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 50),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Email",
                        labelText: "Email"),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Password",
                        labelText: "Password"),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(MyRoutes.home);
                  },
                  child: const Text("Login")),
            ],
          ),
        ));
  }
}
