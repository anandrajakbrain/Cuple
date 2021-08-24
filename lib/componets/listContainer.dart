import 'package:cuple_app/model/notificationsListsResponse.dart';
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
        title: Text(
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
            onPressed: () {}),
      ),
    );
  }
}
