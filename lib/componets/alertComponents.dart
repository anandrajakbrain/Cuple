import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AlertComponets extends StatefulWidget {
  final Handler;
  String title;
  Widget child;
  bool isCancel = true;
  AlertComponets({this.title, this.child, this.Handler = null, this.isCancel});
  @override
  _AlertComponetsState createState() => _AlertComponetsState();
}

class _AlertComponetsState extends State<AlertComponets> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: widget.child,
      actions: getHandlerWidget(),
    );
  }

  getHandlerWidget() {
    if (widget.Handler != null) {
      return [
        FlatButton(
          onPressed: () {
            widget.Handler();
          },
          child: Text("Ok"),
        ),
        widget.isCancel == true
            ? FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        )
            : SizedBox(
          height: 1,
        ),
      ];
    } else {
      return [
        widget.isCancel == true
            ? FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        )
            : SizedBox(
          height: 1,
        ),
      ];
    }
  }
}
