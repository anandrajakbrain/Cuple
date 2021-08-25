import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/listContainer.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/notificationsListsResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'notificationListScreen.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() =>
      _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  NotificationsListsResponse notificationsListsResponse;

  fetch(var id) async {
    NotificationsListsResponse _notificationsListsResponse =
    await Plugs(context).getNotificationList(id, name: "");

    setState(() {
      notificationsListsResponse=_notificationsListsResponse;
    });
  }

  List msgs = ["Hello!", "Hey, Whats up", "....."];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Future.delayed(Duration(seconds: 2)).then((value) => fetch(1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        backgroundColor: APP_BAR_COLOR,
        title: Text(
          "Love Diary",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationsListScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: APP_BAR_COLOR,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
        elevation: 0,
      ),
      body: Container(
        color: APP_BAR_COLOR,
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "\tChat with Your Partner",
                style: TextStyle(color: Colors.black,
                  fontSize: Utils(context).getMediaHeight() * 0.024
                ),
              ),
              Padding(padding: EdgeInsets.only(top: Utils(context).getMediaHeight() * 0.035)),
              ListView.builder(
                shrinkWrap: true,
                  itemCount: msgs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: Utils(context).getMediaWidth() * 0.7,
                      padding: EdgeInsets.all(Utils(context).getMediaHeight() * 0.01),
                      child: Row(
                        mainAxisAlignment: index%2 == 0 ? MainAxisAlignment.start : MainAxisAlignment.end,
                        children: [
                          index%2 == 0 ? Flexible(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.asset("assets/profile_user.jpg",fit: BoxFit.cover,
                                height: 50.0,
                                width: 50.0,
                              ),
                            ),
                          ) : Container(),
                          index%2 == 0 ? Padding(padding: EdgeInsets.only(left: Utils(context).getMediaHeight() * 0.005),)
                          : Container(),
                          Column(
                            crossAxisAlignment: index%2 == 0 ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: index%2 == 0 ? Colors.purpleAccent : Colors.deepPurpleAccent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: index%2 == 0 ? Radius.circular(0) : Radius.circular(10),
                                    bottomRight: index%2 == 0 ? Radius.circular(10) : Radius.circular(0)
                                  )
                                ),
                                padding: EdgeInsets.all(Utils(context).getMediaHeight() * 0.015),
                                //width: Utils(context).getMediaWidth() * 0.6,
                                child: Row(
                                  children: [
                                    Text("${msgs[index]}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Utils(context).getMediaHeight() * 0.022
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(left: Utils(context).getMediaHeight() * 0.015),)
                                  ],
                                )
                              ),
                              Text(
                                "10:00 PM | 24 Jun, 2021",
                                style: TextStyle(color: Colors.grey,
                                    fontSize: Utils(context).getMediaHeight() * 0.015
                                ),
                              ),
                            ],
                          ),
                          index%2 != 0 ? Padding(padding: EdgeInsets.only(left: Utils(context).getMediaHeight() * 0.015),)
                              : Container(),
                          index%2 != 0 ? Flexible(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.asset("assets/profile_user.jpg",fit: BoxFit.cover,
                                height: 50.0,
                                width: 50.0,
                              ),
                            ),
                          ) : Container(),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
