import 'package:cuple_app/componets/appBarActionButton.dart';
import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/customMenuButton.dart';
import 'package:cuple_app/componets/noInterNetConnectionScreen.dart';
import 'package:cuple_app/componets/noRecordFoundScreen.dart';
import 'package:cuple_app/componets/reminderCard.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/listUserReminderResponse.dart';
import 'package:cuple_app/model/reminder_type_response.dart';
import 'package:cuple_app/screens/createNewReminder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReminderListScreen extends StatefulWidget {
  @override
  _ReminderListScreenState createState() => _ReminderListScreenState();
}

class _ReminderListScreenState extends State<ReminderListScreen> {
  ListUserReminderResponse listUserReminderResponse;
  RemindersTypeResponse remindersTypeResponse;
  RemindersTypeData remindersTypeData;
  List<String> reminderTypeList = List();
  var reminderIdsObj = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((value){
      fetch();
      getReminderType();
    });
  }

  getReminderType() async {
    setState(() {
      remindersTypeResponse = null;
      remindersTypeData = null;
    });
    RemindersTypeResponse _remindersListsResponse =
    await Plugs(context).getreminderType();
    setState(() {
      remindersTypeResponse = _remindersListsResponse;
      for(int i = 0; i < remindersTypeResponse.data.length; i++){
         reminderTypeList.add(remindersTypeResponse.data[i].name);
         reminderIdsObj[remindersTypeResponse.data[i].name] = remindersTypeResponse.data[i].id;
      }
    });
  }

  fetch() async {
    Utils(context).checkInternet().then((value) async {
      if(value==true){


        ListUserReminderResponse _listUserReminderResponse = await Plugs(context)
            .listUserReminderList(userId: userDetails.id.toString());

        setState(() {
          listUserReminderResponse = _listUserReminderResponse;
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APP_BAR_COLOR,
      appBar: AppBar(
        leading: CustomBackButton(),
        backgroundColor: APP_BAR_COLOR,
        title: Text(
          "Dates to Remember",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton.icon(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 15),
              ),
              icon: Icon(Icons.add_circle_outline_outlined),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateNewReminder())).then((value) => fetch());
              },
              label: const Text('Create New'),
            ),
          ),
        ],
      ),
      body: Container(
        // height: Utils(context).getMediaHeight(),
        child: Center(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: reminderTypeList.length,
                itemBuilder: (BuildContext context, int index){
                  return Column(
                    children: [
                      Text(
                        "${reminderTypeList[index]}",
                        style: TextStyle(
                          fontSize: Utils(context).getMediaWidth() * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      listUserReminderResponse!=null? listUserReminderResponse.data
                          .where((element) => element.reminderId == 1)
                          .toList()
                          .length>0?  Flexible(
                        child: GridView.builder(
                            controller: ScrollController(),
                            itemCount:listUserReminderResponse!=null? listUserReminderResponse.data
                                .where((element) => element.reminderId == 1)
                                .toList()
                                .length:0,

                            // physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: Utils(context).getMediaHeight() /
                                  Utils(context).getMediaWidth(),
                              // childAspectRatio:10/10,
                            ),
                            itemBuilder: (BuildContext context, index) {
                              return ReminderCard(
                                userListReminderData: listUserReminderResponse.data
                                    .where(
                                        (element) => element.reminderId == 1)
                                    .toList()[index],
                                handlerCall: (){
                                  fetch();
                                },
                              );
                            }),
                      ):NoRecordFoundScreen():NoRecordFoundScreen(
                        icon: FontAwesomeIcons.fileDownload,
                        msg: "Please Wait",
                      ),
                    ],
                  );
                },
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Anniversary",
                      style: TextStyle(
                        fontSize: Utils(context).getMediaWidth() * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
              listUserReminderResponse!=null? listUserReminderResponse.data
                  .where((element) => element.reminderId == 1)
                  .toList()
                  .length>0?  Flexible(
                child: GridView.builder(
                  controller: ScrollController(),
                    itemCount:listUserReminderResponse!=null? listUserReminderResponse.data
                        .where((element) => element.reminderId == 1)
                        .toList()
                        .length:0,

                    // physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: Utils(context).getMediaHeight() /
                          Utils(context).getMediaWidth(),
                      // childAspectRatio:10/10,
                    ),
                    itemBuilder: (BuildContext context, index) {
                      return ReminderCard(
                        userListReminderData: listUserReminderResponse.data
                            .where(
                                (element) => element.reminderId == 1)
                            .toList()[index],
                        handlerCall: (){
                          fetch();
                        },
                      );
                    }),
              ):NoRecordFoundScreen():NoRecordFoundScreen(
                icon: FontAwesomeIcons.fileDownload,
                msg: "Please Wait",
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Celebration",
                      style: TextStyle(
                        fontSize: Utils(context).getMediaWidth() * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
              listUserReminderResponse!=null? (listUserReminderResponse.data
                  .where((element) => element.reminderId == 2)
                  .toList()
                  .length>0) ?Flexible(
                child: GridView.builder(
                    itemCount: listUserReminderResponse!=null? listUserReminderResponse.data
                        .where((element) => element.reminderId == 2)
                        .toList()
                        .length:0,
                    // shrinkWrap: false,
                    // physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: Utils(context).getMediaHeight() /
                          Utils(context).getMediaWidth(),
                    ),
                    itemBuilder: (BuildContext context, index) {
                      return ReminderCard(userListReminderData: listUserReminderResponse.data
                          .where(
                              (element) => element.reminderId == 2)
                          .toList()[index],
                        handlerCall: (){
                          fetch();
                        },
                      );
                    }),
              ):NoRecordFoundScreen():NoRecordFoundScreen(
                icon: FontAwesomeIcons.fileDownload,
                msg: "Please Wait",
              ),
            ],
          ),
        ),
      ),
    );
  }

  getRerminder(BuildContext context){
    return listUserReminderResponse!=null? listUserReminderResponse.data
        .where((element) => element.reminderId == 1)
        .toList()
        .length>0?  Flexible(
      child: GridView.builder(
          controller: ScrollController(),
          itemCount:listUserReminderResponse!=null? listUserReminderResponse.data
              .where((element) => element.reminderId == 1)
              .toList()
              .length:0,

          // physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: Utils(context).getMediaHeight() /
                Utils(context).getMediaWidth(),
            // childAspectRatio:10/10,
          ),
          itemBuilder: (BuildContext context, index) {
            return ReminderCard(
              userListReminderData: listUserReminderResponse.data
                  .where(
                      (element) => element.reminderId == 1)
                  .toList()[index],
              handlerCall: (){
                fetch();
              },
            );
          }),
    ):NoRecordFoundScreen():NoRecordFoundScreen(
      icon: FontAwesomeIcons.fileDownload,
      msg: "Please Wait",
    );
  }
}
