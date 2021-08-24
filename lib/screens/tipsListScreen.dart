import 'package:cuple_app/componets/appBarActionButton.dart';
import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/customMenuButton.dart';
import 'package:cuple_app/componets/tipsCardContainer.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/tipsListResponse.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TipsListScreen extends StatefulWidget {
  @override
  _TipsListScreenState createState() => _TipsListScreenState();
}

class _TipsListScreenState extends State<TipsListScreen> {


  TipsListResponse tipsListResponse;

  fetch() async {
    TipsListResponse _tipsListResponse =
    await Plugs(context).getTipsList(type: "tips");

    setState(() {
      tipsListResponse=_tipsListResponse;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((value) => fetch());
  }
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
        elevation: 0.0,
      ),
      body: Container(
        child: Center(
          child: GridView.builder(
              itemCount: tipsListResponse!=null?tipsListResponse.data.length:0,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, index) {
                return TipsCardContainer(tipsData: tipsListResponse.data[index]);
              }),
        ),
      ),
    );
  }
}
