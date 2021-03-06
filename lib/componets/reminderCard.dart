import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/deleteWishListResponse.dart';
import 'package:cuple_app/model/listUserReminderResponse.dart';
import 'package:cuple_app/model/sendPartnerRequestResponse.dart';
import 'package:cuple_app/screens/editReminder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ReminderCard extends StatefulWidget {
  UserListReminderData userListReminderData;
  final handlerCall;

  ReminderCard({@required this.userListReminderData, this.handlerCall = null});

  @override
  _ReminderCardState createState() => _ReminderCardState();
}

class _ReminderCardState extends State<ReminderCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        Utils(context).showAlert(
            context: context,
            title: "Options",
            child: Container(
              height: Utils(context).getMediaHeight() * 0.24,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      icon: Icon(Icons.favorite),
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () async {
                        print(widget.userListReminderData.id);
                        SendPartnerRequestResponse sendResult =
                            await Plugs(context).addToFavourites(
                                reminderId:
                                    widget.userListReminderData.id.toString(),
                                action: widget.userListReminderData.favourite ==
                                        'yes'
                                    ? 'no'
                                    : 'yes');
                        Navigator.pop(context);
                        widget.handlerCall();
                      },
                      label: Expanded(
                          child: Text(
                        "${widget.userListReminderData.favourite == 'yes' ? 'Remove' : 'Add'} To Favourites",
                      )),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      icon: Icon(FontAwesomeIcons.pencilAlt),
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditReminder(
                                      userListReminderData:
                                          widget.userListReminderData,
                                  callback: (){
                                        widget.handlerCall();
                                  },
                                    )));
                      },
                      label: const Text('Edit                  '),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      icon: Icon(Icons.delete_outline),
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () async {
                        print(widget.userListReminderData.id);
                        DeleteWishListResponse deleteWishListResponse =
                            await Plugs(context).dELETEUSERREMINDERS(
                                id: widget.userListReminderData.id.toString());
                        Navigator.pop(context);
                        widget.handlerCall();
                      },
                      label: const Text('Delete                  '),
                    ),
                  ),
                ],
              ),
            ));
      },
      child: Container(
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
                  fontSize: Utils(context).getMediaWidth() * 0.03),
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
                DateFormat("MMM d,y").format(
                  DateTime.parse(widget.userListReminderData.date),
                ),
                // "June 28,2021",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: Utils(context).getMediaWidth() * 0.03),
              ),
            ),
            // SizedBox(
            //   height: Utils(context).getMediaHeight() * 0.01,
            // ),
            Text(
              getInDays(inputDate: widget.userListReminderData.date)
                      .toString() +
                  " Days",
              // "${DateTime.parse(widget.userListReminderData.date).difference(DateTime.now()).inDays} days",//"",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: Utils(context).getMediaWidth() * 0.03),
            ),
            // SizedBox(
            //   height: Utils(context).getMediaHeight() * 0.01,
            // ),
            FittedBox(
              child: Text(
                "To Celebrate ${widget.userListReminderData.name}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: Utils(context).getMediaWidth() * 0.03),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
