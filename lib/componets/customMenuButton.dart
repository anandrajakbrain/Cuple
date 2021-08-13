import 'package:flutter/material.dart';

class CustomMenuButton extends StatefulWidget {
  @override
  _CustomMenuButtonState createState() => _CustomMenuButtonState();
}

class _CustomMenuButtonState extends State<CustomMenuButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              blurRadius: 2,
              spreadRadius: 1,
            )
          ],
        ),
        child: Icon(
          Icons.menu,
          color: Colors.black,
        ),
      ),
    );
  }
}
