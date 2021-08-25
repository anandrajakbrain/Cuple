import 'package:cuple_app/componets/appBarActionButton.dart';
import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/customMenuButton.dart';
import 'package:cuple_app/componets/reminderCard.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/listUserReminderResponse.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((value) => fetch());
  }

  fetch() async {
    ListUserReminderResponse _listUserReminderResponse = await Plugs(context)
        .listUserReminderList(userId: userDetails.id.toString());

    setState(() {
      listUserReminderResponse = _listUserReminderResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        backgroundColor: APP_BAR_COLOR,
        title: Text(
          "Reminders",
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
              Flexible(
                child: GridView.builder(
                    itemCount:listUserReminderResponse!=null? listUserReminderResponse.data
                        .where((element) => element.category == "Anniversary")
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
                                (element) => element.category == "Anniversary")
                            .toList()[index],
                      );
                    }),
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
              Flexible(
                child: GridView.builder(
                    itemCount: listUserReminderResponse!=null? listUserReminderResponse.data
                        .where((element) => element.category == "Celebration")
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
                              (element) => element.category == "Celebration")
                          .toList()[index]);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
