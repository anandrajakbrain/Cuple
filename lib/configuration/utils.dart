import 'dart:convert';

import 'package:cuple_app/componets/progressLoader.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/model/verifyOTPResponse.dart';
import 'package:cuple_app/screens/home_screen.dart';
import 'package:cuple_app/screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:html/parser.dart';
class Utils {
  BuildContext context;

  Utils(@required this.context);

  double getMediaWidth() {
    return MediaQuery.of(context).size.width;
  }

  double getMediaHeight() {
    return MediaQuery.of(context).size.height;
  }

 Future<Widget> checkUser() async {
    SharedPreferences prf = await SharedPreferences.getInstance();
    // print(prf.getString("user"));
    if (prf.containsKey("user")) {
      userDetails=User.fromJson(jsonDecode(prf.getString("user")));
      token=prf.getString("token");
    return HomeScreen();
    }else{
      return LoginScreen();
    }
  }
  String parseHtmlString(String htmlString) {
    var document = parse(htmlString);

    String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }
  showProgressLoader() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return CustomProgressLoader();
        });
  }

  showMessage(
      {String title, Widget child, final handler, bool isCancel = true}) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: child,
            // actions: [],
          );
        });
  }
}
