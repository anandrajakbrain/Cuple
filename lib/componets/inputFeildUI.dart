import 'package:cuple_app/configuration/utils.dart';
import 'package:flutter/material.dart';

class RegisterInputField extends StatefulWidget {
  TextEditingController controller;
  String labelName;
  String formType;
  TextInputType TxtInputType;

  RegisterInputField(
      {@required this.controller, @required this.labelName, this.TxtInputType,this.formType});

  @override
  _RegisterInputFieldState createState() => _RegisterInputFieldState();
}

class _RegisterInputFieldState extends State<RegisterInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: widget.TxtInputType,
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.labelName,
          labelStyle: TextStyle(
            fontSize: Utils(context).getMediaWidth() * 0.059,
            color: Colors.grey[500],
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.grey[300],
              // width: 2.0,
            ),
          ),
        ),
        validator: (value) {
          if(value.isEmpty){
            return "! Please Fill ${widget.labelName} ";

          }
          if(widget.formType=="email"){
            if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
              return 'Enter a valid email!';
            }
          } if(widget.formType=="phone"){
            if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                    .hasMatch(value)) {
              return 'Enter a valid Phone Number!';
            }
          }


          return null;
        },
      ),
    );
  }

}
