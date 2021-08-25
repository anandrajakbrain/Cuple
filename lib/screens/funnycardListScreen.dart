import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/funnyCardContainer.dart';
import 'package:cuple_app/componets/noRecordFoundScreen.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/model/funnycardsListsResponse.dart';
import 'package:flutter/material.dart';

class FunnyCardListScreen extends StatefulWidget {
  final String partnerName;

  FunnyCardListScreen({@required this.partnerName});

  @override
  _FunnyCardListScreenState createState() => _FunnyCardListScreenState();
}

class _FunnyCardListScreenState extends State<FunnyCardListScreen> {
  FunnycardsListsResponse funnycardsListsResponse;

  fetch() async {
    FunnycardsListsResponse _funnycardsListsResponse = await Plugs(context).getFunnyCards(type: "tips");

    setState(() {
      funnycardsListsResponse = _funnycardsListsResponse;
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
              }):NoRecordFoundScreen():NoRecordFoundScreen(),
        ),
      ),
    );
  }
}
