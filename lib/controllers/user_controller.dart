import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../config/keys.dart';

enum LoginState { notLoggedIn, loggingIn, loggedIn }

class UserController extends GetxController {
  final box = GetStorage();
  late String? _authToken = "";
  late LoginState loginState = LoginState.notLoggedIn;

  @override
  void onInit() {
    _authToken = box.read<String>("authToken2") ?? "";
    super.onInit();
  }

  void loginUser(String username, String password) async {
    loginState = LoginState.loggingIn;
    update();
    if (_authToken != "") {
      validateAuthToken();
    } else {
      GetConnect connect = GetConnect();
      var loginResult = await connect.post(Keys.loginUrl, {
        "user": {"username": username, "password": password}
      });
      if (loginResult.hasError) {
        Get.snackbar("Error", "Login failed");
        loginState = LoginState.notLoggedIn;
      } else {
        var jsonResponse = jsonDecode(loginResult.bodyString!);
        bool loginSuccess = jsonResponse["success"];
        if (loginSuccess) {
          loginState = LoginState.loggedIn;
          _authToken = jsonResponse["token"];
          Get.snackbar("Success!", "Logged in successfully.");
        } else {
          loginState = LoginState.notLoggedIn;
          _authToken = "";
        }
      }
      update();
    }
  }

  void logoutUser(){
   _authToken = "";
   loginState = LoginState.notLoggedIn;
   update();
  }

  void validateAuthToken() async {
    GetConnect connect = GetConnect();
    Map<String, String> headers = {"x-access-token": _authToken ?? ""};
    var authTokenResult =
        await connect.get(Keys.validateAuthUrl, headers: headers);
    var jsonResponse = jsonDecode(authTokenResult.bodyString.toString());
    if (jsonResponse["success"] == true) {
      loginState = LoginState.loggedIn;
    } else {
      loginState = LoginState.notLoggedIn;
    }
    update();
  }
}
