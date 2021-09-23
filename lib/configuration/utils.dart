import 'dart:convert';

import 'package:cuple_app/componets/alertComponents.dart';
import 'package:cuple_app/componets/progressLoader.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/model/verifyOTPResponse.dart';
import 'package:cuple_app/screens/home_screen.dart';
import 'package:cuple_app/screens/login.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:html/parser.dart';

String devieToken;

class Utils {
  BuildContext context;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  Utils(@required this.context);

  double getMediaWidth() {
    return MediaQuery.of(context).size.width;
  }

  double getMediaHeight() {
    return MediaQuery.of(context).size.height;
  }

  getToken() async {
    print("Token Fnction Call");
    firebaseMessaging.getToken().then((token) {
      print("Token : " + token);
      devieToken = token; // Print the Token in Console
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("deviceToken", devieToken);
    // UtilitiesMethods(context).showMessage(context: context,title:"Toke",child: Text(tokenData.toString()));
    print("Device Token : " + pref.getString("deviceToken").toString());
  }

  Future<Widget> checkUser() async {
    SharedPreferences prf = await SharedPreferences.getInstance();
    // print(prf.getString("user"));
    if (prf.containsKey("user")) {
      userDetails = User.fromJson(jsonDecode(prf.getString("user")));
      token = prf.getString("token");
      return HomeScreen();
    } else {
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

  showAlert({
    BuildContext context,
    String title,
    Widget child,
    final handler = null,
    bool isCancel = true,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertComponets(
            title: title,
            child: child,
            Handler: handler,
            isCancel: isCancel,
          );
        });
  }

  logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false);
  }

  Future<bool> checkInternet() async {
    bool result = await DataConnectionChecker().hasConnection;
    print("Has Connection $result");
    return result;
  }


}
String getInDays({String inputDate}) {
  String daysData;
  if (DateTime.parse(inputDate).difference(DateTime.now()).inDays >=0) {
    // print();
    daysData = DateTime.parse(inputDate)
        .difference(DateTime.now())
        .inDays
        .toString();
    return daysData;
  } else {
    var tmp = DateTime.parse(inputDate);
    DateTime now = DateTime.now();
    daysData =
        DateTime.utc(now.add(Duration(days: 364)).year, tmp.month, tmp.day)
            .difference(DateTime.now())
            .inDays
            .toString();
    return daysData;
    // print();
  }
}