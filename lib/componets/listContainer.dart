import 'package:flutter/material.dart';

class ListContainer extends StatefulWidget {
  bool isEven;

  ListContainer({@required this.isEven});

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
          "10:00AM 15 Jun,2021",
          style: TextStyle(
              color: widget.isEven == true ? Colors.white70 : Colors.black54,
              fontSize: 14),
        ),
        subtitle: Text(
          "The BoxDecoration class provides a variety of ways to draw a box. The box has a border, a body, and may cast a boxShadow. The shape of the box can be a circle or a rectangle. If it is a rectangle, then the borderRadius property controls the roundness of the corners.",
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
