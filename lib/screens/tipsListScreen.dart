import 'package:cuple_app/componets/appBarActionButton.dart';
import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/customMenuButton.dart';
import 'package:cuple_app/componets/noInterNetConnectionScreen.dart';
import 'package:cuple_app/componets/noRecordFoundScreen.dart';
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
    Utils(context).checkInternet().then((value) async {
      if(value==true){

        TipsListResponse _tipsListResponse =
        await Plugs(context).getTipsList(type: "tips");

        setState(() {
          tipsListResponse=_tipsListResponse;
        });


      }


      else {
        Utils(context).showAlert(
            context: context,
            title: "",
            child: Container(
                height: 250, width: 150, child: NoInternetConnectionScreen()),
            handler: () {
              Navigator.pop(context);
              fetch();
            },
            isCancel: false);
      }


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
          "${suggesiontypeListsResponse!=null?suggesiontypeListsResponse.data.where((element) => element.id==2).first.name:'Love Tips'}",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
         
        ],
        elevation: 0.0,
      ),
      body: Container(
        child: Center(
          child: tipsListResponse!=null?tipsListResponse.data.length>0?
          GridView.builder(
              itemCount: tipsListResponse!=null?tipsListResponse.data.length:0,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              controller: ScrollController(),
              itemBuilder: (BuildContext context, index) {
                return tipsListResponse.data[index].id == 2 ? TipsCardContainer(tipsData: tipsListResponse.data[index]) : Container();
              }):NoRecordFoundScreen():NoRecordFoundScreen(icon: FontAwesomeIcons.fileDownload,msg: "Please Wait",
          ),
        ),
      ),
    );
  }
}
