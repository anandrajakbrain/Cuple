import 'package:cuple_app/componets/appBarActionButton.dart';
import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/customMenuButton.dart';
import 'package:cuple_app/componets/reminderCard.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/screens/createNewReminder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:custom_switch/custom_switch.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationToggleStatus = false;
  bool chatToggleStatus = false;
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        backgroundColor: APP_BAR_COLOR,
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Container(
        // height: Utils(context).getMediaHeight(),
        child: Center(
          child: Column(
            children: [
              ListTile(
                leading: Text("Notification -",
                  style: TextStyle(
                    fontSize: Utils(context).getMediaHeight() * 0.025
                  ),
                ),
                title: Text("${notificationToggleStatus ? 'On' : 'Off'}",
                  style: TextStyle(
                      fontSize: Utils(context).getMediaHeight() * 0.025
                  ),
                ),
                trailing: CustomSwitch(
                  activeColor: Colors.blue,
                  value: notificationToggleStatus,
                  onChanged: (value) {
                    print("VALUE : $value");
                    setState(() {
                      notificationToggleStatus = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.02,
              ),
              ListTile(
                leading: Text("Frequency",
                  style: TextStyle(
                      fontSize: Utils(context).getMediaHeight() * 0.025
                  ),
                ),
                trailing: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 0,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['One', 'Two', 'Free', 'Four']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              ),
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.02,
              ),
              Divider(height: 0.08,),
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.02,
              ),
              ListTile(
                leading: Text("Chat -",
                  style: TextStyle(
                      fontSize: Utils(context).getMediaHeight() * 0.025
                  ),
                ),
                title: Text("${chatToggleStatus ? 'On' : 'Off'}",
                  style: TextStyle(
                      fontSize: Utils(context).getMediaHeight() * 0.025
                  ),
                ),
                trailing: CustomSwitch(
                  activeColor: Colors.blue,
                  value: chatToggleStatus,
                  onChanged: (value) {
                    print("VALUE : $value");
                    setState(() {
                      chatToggleStatus = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.02,
              ),
              ListTile(
                  leading: Text("Message Frequency",
                    style: TextStyle(
                        fontSize: Utils(context).getMediaHeight() * 0.025
                    ),
                  ),
                  trailing: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 0,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>['One', 'Two', 'Free', 'Four']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
              ),
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.02,
              ),
              Divider(height: 0.08,),
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.02,
              ),
              ListTile(
                  leading: Text("Date Nights",
                    style: TextStyle(
                        fontSize: Utils(context).getMediaHeight() * 0.025
                    ),
                  ),
                  trailing: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 0,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>['One', 'Two', 'Free', 'Four']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
              ),
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.02,
              ),
              Divider(height: 0.08,),
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.02,
              ),
              ListTile(
                  leading: Text("Questionnaire",
                    style: TextStyle(
                        fontSize: Utils(context).getMediaHeight() * 0.025
                    ),
                  ),
                  trailing: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 0,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>['One', 'Two', 'Free', 'Four']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
              ),
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.02,
              ),
              Divider(height: 0.08,),
            ],
          ),
        ),
      ),
    );
  }
}
