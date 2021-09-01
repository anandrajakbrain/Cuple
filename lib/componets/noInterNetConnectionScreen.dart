import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:flutter/material.dart';
class NoInternetConnectionScreen extends StatefulWidget {
  @override
  _NoInternetConnectionScreenState createState() => _NoInternetConnectionScreenState();
}

class _NoInternetConnectionScreenState extends State<NoInternetConnectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: APP_BAR_COLOR,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(8.0),
              height: Utils(context).getMediaHeight()*0.08,
              child: Image.asset("assets/no-wifi.png"),
            ),
            Text("No Internet Connection",style: TextStyle(
              fontSize: Utils(context).getMediaWidth()*0.05,
              fontWeight: FontWeight.bold,

            ),)
          ],
        ),
      ),
    );
  }
}
