import 'package:cuple_app/componets/listContainer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationsListScreen extends StatefulWidget {
  @override
  _NotificationsListScreenState createState() =>
      _NotificationsListScreenState();
}

class _NotificationsListScreenState extends State<NotificationsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
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
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Notifications",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 15),
              ),
              onPressed: () {},
              child: const Text('Clear All'),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListContainer(isEven: index.isEven);
              }),
        ),
      ),
    );
  }
}
