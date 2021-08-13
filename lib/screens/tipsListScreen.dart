import 'package:cuple_app/componets/appBarActionButton.dart';
import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/customMenuButton.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TipsListScreen extends StatefulWidget {
  @override
  _TipsListScreenState createState() => _TipsListScreenState();
}

class _TipsListScreenState extends State<TipsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        backgroundColor: APP_BAR_COLOR,
        title: Text(
          "Tips",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
         
        ],
      ),
      body: Container(
        child: Center(
          child: GridView.builder(
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, index) {
                return Container(
                  height: Utils(context).getMediaHeight() * 0.6,
                  
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Color(0XFFE8F6F1),
                  borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[200],
                          spreadRadius: 2,
                          // blurRadius: 1
                        ),
                      ]
                  ),
                  child: GridTile(
                    header: Container(
                      padding: EdgeInsets.only(top: 10.0, bottom: 8.0),
                      child: Image.asset(
                        "assets/tipsImg.png",
                        // fit: BoxFit.cover,
                        height: Utils(context).getMediaHeight() * 0.14,
                        width: 1,
                      ),
                    ),
                    child: SizedBox(),
                    footer: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Love Language",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: Utils(context).getMediaWidth() * 0.05,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
