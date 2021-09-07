import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/listContainer.dart';
import 'package:cuple_app/componets/noInterNetConnectionScreen.dart';
import 'package:cuple_app/componets/noRecordFoundScreen.dart';
import 'package:cuple_app/componets/tutorialListContainer.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/notificationsListsResponse.dart';
import 'package:cuple_app/model/tutorialsListsResponse.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TutorialListScreen extends StatefulWidget {
  @override
  _TutorialListScreenState createState() => _TutorialListScreenState();
}

class _TutorialListScreenState extends State<TutorialListScreen> {

  TutorialsListsResponse tutorialsListsResponse;
  fetch(var id) async {

    Utils(context).checkInternet().then((value) async {
      if(value==true){

        TutorialsListsResponse _tutorialsListsResponse =
        await Plugs(context).getTutorialList();

        setState(() {
          tutorialsListsResponse = _tutorialsListsResponse;
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
              fetch(userDetails.id.toString());
            },
            isCancel: false);
      }


    });




  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 0)).then((value) => fetch(userDetails.id.toString()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        backgroundColor: APP_BAR_COLOR,
        title: Text(
          "Tutorials",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
         /* InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  // deleteAll(delIds);
                },
                child: const Text('Clear All'),
              ),
            ),
          ),*/
        ],
        elevation: 0,
      ),
      body: Container(
        color: APP_BAR_COLOR,
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: tutorialsListsResponse != null
              ? tutorialsListsResponse.data.length > 0
              ? ListView.builder(
              itemCount: tutorialsListsResponse != null
                  ? tutorialsListsResponse.data.length
                  : 0,
              itemBuilder: (context, index) {

                return TutorialListContainer(
                  isEven: index.isEven,
                  tutorialData:
                  tutorialsListsResponse.data[index],
                );
              })
              : NoRecordFoundScreen(msg: "No Tutorials Found",)
              : NoRecordFoundScreen(
            icon: FontAwesomeIcons.fileDownload,
            msg: "Please Wait",
          ),
        ),
      ),
    );
  }
}
