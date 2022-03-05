import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lion_tinder_app/controllers/user_controller.dart';

class UserLandingPage extends StatelessWidget {
  const UserLandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 400,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/lionBlack.jpg'),
                    fit: BoxFit.fitWidth)),
              child: SizedBox(height: 20, width: 20,
                child: ElevatedButton(
                    onPressed: () {
                      Get.find<UserController>().logoutUser();
                    },
                    child: const Text("Logout")),
              )
          ),
        ],
      ),
    );
  }
}
