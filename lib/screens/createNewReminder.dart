import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/customMenuButton.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:flutter/material.dart';

class CreateNewReminder extends StatefulWidget {
  @override
  _CreateNewReminderState createState() => _CreateNewReminderState();
}

class _CreateNewReminderState extends State<CreateNewReminder> {
  List<String> categoryType = [
    'Anniversary',
    'Celebration',
  ];
  String reminderTypeVal, reminderNameVal;
  TextEditingController dateInputController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text(
          "Create New Reminder",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: APP_BAR_COLOR,
      elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.06,
              ),
              DropdownButtonFormField(
                value: reminderTypeVal,
                items: categoryType
                    .map(
                      (e) => DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      ),
                    )
                    .toList(),
                decoration: InputDecoration(
                  labelText: "Reminder Type",
                  labelStyle: TextStyle(
                      fontSize: Utils(context).getMediaWidth() * 0.04),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    reminderTypeVal = value;
                  });
                },
              ),
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.03,
              ),
              DropdownButtonFormField(
                value: reminderNameVal,
                items: categoryType
                    .map(
                      (e) => DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      ),
                    )
                    .toList(),
                decoration: InputDecoration(
                  labelText: "Reminder Name",
                  labelStyle: TextStyle(
                      fontSize: Utils(context).getMediaWidth() * 0.04),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    reminderNameVal = value;
                  });
                },
              ),
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.03,
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: dateInputController,
                  decoration: InputDecoration(
                    labelText: "Date",
                    labelStyle: TextStyle(
                      fontSize: Utils(context).getMediaWidth() * 0.04,
                      color: Colors.grey[500],
                    ),
                    suffixIcon: Icon(Icons.calendar_today),
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
                    if (value.isEmpty) {
                      return "! Please Select Date ";
                    }

                    return null;
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  // if (_formKey.currentState.validate()) {
                  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerificationScreen()));
                  // }
                },
                child: SizedBox(
                  width: Utils(context).getMediaWidth() * 0.80,
                  child: Container(
                    padding: EdgeInsets.all(14.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0XFF1E8FED), Color(0XFF6341DF)]),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Center(
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Utils(context).getMediaWidth() * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
