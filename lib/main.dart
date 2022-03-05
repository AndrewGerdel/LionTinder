import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lion_tinder_app/controllers/user_controller.dart';
import 'package:lion_tinder_app/screens/user_landing_page.dart';
import 'package:lion_tinder_app/screens/user_login.dart';

void main() async {
  Get.put(UserController());
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Lion Tinder'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key("mainScaffold"),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('View Lions'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                Get.find<UserController>().logoutUser();
                Navigator.of(context).pop();
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            GetBuilder<UserController>(
              init: UserController(),
              builder: (controller) {
                switch (controller.loginState) {
                  case LoginState.loggedIn:
                    return UserLandingPage();
                  case LoginState.notLoggedIn:
                    return UserLoginScreen();
                  case LoginState.loggingIn:
                    return CircularProgressIndicator();
                }
              },
            )
          ])),
    );
  }
}
