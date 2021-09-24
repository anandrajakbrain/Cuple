import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/funnyCardContainer.dart';
import 'package:cuple_app/componets/hartScreen.dart';
import 'package:cuple_app/componets/noInterNetConnectionScreen.dart';
import 'package:cuple_app/componets/noRecordFoundScreen.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/funnycardsListsResponse.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FunnyCardListScreen extends StatefulWidget {
  final String partnerName;

  FunnyCardListScreen({@required this.partnerName});

  @override
  _FunnyCardListScreenState createState() => _FunnyCardListScreenState();
}

class _FunnyCardListScreenState extends State<FunnyCardListScreen> {
  FunnycardsListsResponse funnycardsListsResponse;

  fetch() async {

    Utils(context).checkInternet().then((value) async {
      if (value == true) {
        FunnycardsListsResponse _funnycardsListsResponse = await Plugs(context)
            .getFunnyCards(type: "tips");

        setState(() {
          funnycardsListsResponse = _funnycardsListsResponse;
        });
      } else {
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
          "Funny Cards for ${widget.partnerName}",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: APP_BAR_COLOR,
        ),
        child: Center(
          child:funnycardsListsResponse!=null?funnycardsListsResponse.data.length>0 ?GridView.builder(
              itemCount: funnycardsListsResponse != null ? funnycardsListsResponse.data.length : 0,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return FunnyCardContainer(
                    funnyCardData: funnycardsListsResponse.data[index]);
              }):HartScreenComponent():NoRecordFoundScreen(icon: FontAwesomeIcons.fileDownload,msg: "Please Wait",),
        ),
      ),
    );
  }
}
