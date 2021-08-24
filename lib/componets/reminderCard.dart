import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/listUserReminderResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReminderCard extends StatefulWidget {

  UserListReminderData userListReminderData;
  ReminderCard({@required this.userListReminderData});
  @override
  _ReminderCardState createState() => _ReminderCardState();
}

class _ReminderCardState extends State<ReminderCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: Utils(context).getMediaHeight() * 0.01,
      margin: EdgeInsets.all(5.0),
      // padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          gradient: REMINDER_CARD_COLOR,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              spreadRadius: 2,
              color: Colors.grey[300],
              blurRadius: 1,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${widget.userListReminderData.name}",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize:
                Utils(context).getMediaWidth() * 0.03),
          ),
          SizedBox(
            height: Utils(context).getMediaHeight() * 0.01,
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0XFF2487EC),
                Color(0XFF663DDF),
              ]),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
             DateFormat("MMM d,y").format(DateTime.parse(widget.userListReminderData.date),),// "June 28,2021",
              style: TextStyle(
                  color: Colors.white,
                  fontSize:
                  Utils(context).getMediaWidth() * 0.03),
            ),
          ),
          // SizedBox(
          //   height: Utils(context).getMediaHeight() * 0.01,
          // ),
          Text(
            "${DateTime.parse(widget.userListReminderData.date).difference(DateTime.now()).inDays} days",//"",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize:
                Utils(context).getMediaWidth() * 0.03),
          ),
          // SizedBox(
          //   height: Utils(context).getMediaHeight() * 0.01,
          // ),
          Text(
            "To Celebrate Anniversary",
            style: TextStyle(
                color: Colors.white,
                fontSize:
                Utils(context).getMediaWidth() * 0.03),
          ),
        ],
      ),
    );
  }
}
