import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/model/notificationsListsResponse.dart';
import 'package:cuple_app/screens/notificationListScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListContainer extends StatefulWidget {
  bool isEven;
NotificationListData notificationListData;

  ListContainer({@required this.isEven,this.notificationListData});

  @override
  _ListContainerState createState() => _ListContainerState();
}

class _ListContainerState extends State<ListContainer> {
  var deleteNotificationsListsResponse;

  fetch(var id) async {
    var _notificationsListsResponse =
    await Plugs(context).deleteNotification(id, name: "");
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => NotificationsListScreen()));
    setState(() {
      deleteNotificationsListsResponse=_notificationsListsResponse;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: widget.isEven == true ? Color(0XFF9366ED) : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(color: Colors.grey, spreadRadius: 2, blurRadius: 1)
        ],
      ),
      child: ListTile(
        title: Text(widget.notificationListData.createdAt == null ? "24-08-2021 18:52" :
          DateFormat.yMMMEd().format(DateTime.parse(widget.notificationListData.createdAt)),
          style: TextStyle(
              color: widget.isEven == true ? Colors.white70 : Colors.black54,
              fontSize: 14),
        ),
        subtitle: Text(
          "${widget.notificationListData.msg}",
          style: TextStyle(
              color: widget.isEven == true ? Colors.white : Colors.black,
              fontSize: 17),
        ),
        trailing: IconButton(
            icon: Icon(
              Icons.delete_outline,
              size: 35,
              color: widget.isEven == true ? Colors.white : Colors.black,
            ),
            onPressed: () {
              fetch(widget.notificationListData.id);
            }),
      ),
    );
  }
}
