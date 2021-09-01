import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/listContainer.dart';
import 'package:cuple_app/componets/noInterNetConnectionScreen.dart';
import 'package:cuple_app/componets/noRecordFoundScreen.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/notificationsListsResponse.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationsListScreen extends StatefulWidget {
  @override
  _NotificationsListScreenState createState() =>
      _NotificationsListScreenState();
}

class _NotificationsListScreenState extends State<NotificationsListScreen> {
  NotificationsListsResponse notificationsListsResponse;
  var deleteAllResponse;
  List ids = [];
  String delIds = "";

  fetch(var id) async {

    Utils(context).checkInternet().then((value) async {
      if(value==true){

        NotificationsListsResponse _notificationsListsResponse =
        await Plugs(context).getNotificationList(id, name: "");

        setState(() {
          notificationsListsResponse = _notificationsListsResponse;
        });

      }


      else {
        Utils(context).showAlert(
            context: context,
            title: "",
            child: Container(
                height: 100, width: 100, child: NoInternetConnectionScreen()),
            handler: () {
              Navigator.pop(context);
              fetch(userDetails.id.toString());
            },
            isCancel: false);
      }


    });




  }

  deleteAll(String ids) async {
    var _deleteAllResponse =
        await Plugs(context).deleteAllNotifications(delIds, name: "");
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => NotificationsListScreen()));
    setState(() {
      deleteAllResponse = _deleteAllResponse;
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
          "Notifications",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  deleteAll(delIds);
                },
                child: const Text('Clear All'),
              ),
            ),
          ),
        ],
        elevation: 0,
      ),
      body: Container(
        color: APP_BAR_COLOR,
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: notificationsListsResponse != null
              ? notificationsListsResponse.data.length > 0
                  ? ListView.builder(
                      itemCount: notificationsListsResponse != null
                          ? notificationsListsResponse.data.length
                          : 0,
                      itemBuilder: (context, index) {
                        if (index == 0)
                          delIds +=
                              "delids[$index]=${notificationsListsResponse.data[index].id}";
                        else
                          delIds +=
                              "&delids[$index]=${notificationsListsResponse.data[index].id}";
                        ids.add(notificationsListsResponse.data[index].id);
                        return ListContainer(
                          isEven: index.isEven,
                          notificationListData:
                              notificationsListsResponse.data[index],
                        );
                      })
                  : NoRecordFoundScreen(msg: "No Notification Found",)
              : NoRecordFoundScreen(
            icon: FontAwesomeIcons.fileDownload,
            msg: "Please Wait",
          ),
        ),
      ),
    );
  }
}
