import 'package:flutter/material.dart';

class AppBarActionButton extends StatefulWidget {
  Icon buttonIcon;
  AppBarActionButton({@required this.buttonIcon});
  @override
  _AppBarActionButtonState createState() => _AppBarActionButtonState();
}

class _AppBarActionButtonState extends State<AppBarActionButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
padding: EdgeInsets.all(8.0),
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
      child: widget.buttonIcon,
    );
  }
}
