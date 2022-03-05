import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lion_tinder_app/controllers/user_controller.dart';
import 'package:lion_tinder_app/screens/user_landing_page.dart';

class UserLoginScreen extends StatelessWidget {
  UserLoginScreen({Key? key}) : super(key: key);

  late String _username = "";
  late String _password = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        children: [
          const Text("Welcome to Lion Tinder, where lions really roar!"),
          const Text("Login Below"),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == "") {
                      return "Username is required";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _username = value;
                  },
                  decoration: const InputDecoration(hintText: "Username..."),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == "") {
                      return "Password is required";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _password = value;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(hintText: "Password..."),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        var userController = Get.find<UserController>();
                        userController.loginUser(_username, _password);
                        if (userController.loginState == LoginState.loggedIn) {
                          Get.to(const UserLandingPage());
                        }
                      }

                    },
                    child: const Text("Login"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
