import 'package:cuple_app/componets/appBarActionButton.dart';
import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/customMenuButton.dart';
import 'package:cuple_app/componets/reminderCard.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/settingsResponse.dart';
import 'package:cuple_app/model/verifyOTPResponse.dart';
import 'package:cuple_app/screens/createNewReminder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:custom_switch/custom_switch.dart';

class SettingsScreen extends StatefulWidget {
  final User userDetails;

  SettingsScreen(this.userDetails);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationToggleStatus = false;
  bool chatToggleStatus = false;
  var frequency = "Once a week";
  var questionnaire = "weekly";
  var dateNights = "one in week";
  var msgFrequency = "Once a week";
  bool celebration_subscribe = false;
  SettingsResponse settingsResponse;

  @override
  void initState() {
    super.initState();
    setState(() {
      notificationToggleStatus =
      userSettings.data.nofication == "on" ? true : false;
      chatToggleStatus = userSettings.data.chat == "on" ? true : false;
      frequency = userSettings.data.frequency;
      questionnaire = userSettings.data.questionnaire;
      dateNights = userSettings.data.date_nights;
      msgFrequency = userSettings.data.msg_frequency;
      celebration_subscribe=userSettings.data.celebration_subscribe==0?false:true;
    });
  }

  fetch() async {
    var _userSettingsResponse = await Plugs(context).updateSettings(
        userDetails.id.toString(),
        chatToggleStatus ? "on" : "off",
        notificationToggleStatus ? "on" : "off",
        frequency,
        questionnaire,
        dateNights,
        msgFrequency,
        celebration_subscribe);
    setState(() {
      userDetails.celebration_subscribe = celebration_subscribe ? 1 : 0;
    });
    fetchSettings();
  }

  fetchSettings() async {
    SettingsResponse _settingsResponse = await Plugs(context).getSettings(
        userDetails.id.toString());
    setState(() {
      settingsResponse = _settingsResponse;
      userSettings = settingsResponse;
      notificationToggleStatus =
      settingsResponse.data.nofication == "on" ? true : false;
      chatToggleStatus = settingsResponse.data.chat == "on" ? true : false;
      frequency = settingsResponse.data.frequency;
      questionnaire = settingsResponse.data.questionnaire;
      dateNights = settingsResponse.data.date_nights;
      msgFrequency = settingsResponse.data.msg_frequency;
      celebration_subscribe=settingsResponse.data.celebration_subscribe==0?false:true;
    });
  }

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
                leading: Text(
                  "Notification -",
                  style: TextStyle(
                      fontSize: Utils(context).getMediaHeight() * 0.025),
                ),
                title: Text(
                  "${notificationToggleStatus ? "on" : "off"}",
                  style: TextStyle(
                      fontSize: Utils(context).getMediaHeight() * 0.025),
                ),
                trailing: CustomSwitch(
                  activeColor: Colors.blue,
                  value: notificationToggleStatus,
                  onChanged: (value) {
                    print("VALUE : $value");
                    setState(() {
                      notificationToggleStatus = value;
                    });
                    fetch();
                  },
                ),
              ),
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.02,
              ),
              ListTile(
                leading: Text(
                  "Celebration Subscribe -",
                  style: TextStyle(
                      fontSize: Utils(context).getMediaHeight() * 0.025),
                ),
                title: Text(
                  "${celebration_subscribe ? "on" : "off"}",
                  style: TextStyle(
                      fontSize: Utils(context).getMediaHeight() * 0.025),
                ),
                trailing: CustomSwitch(
                  activeColor: Colors.blue,
                  value: celebration_subscribe,
                  onChanged: (value) {
                    print("VALUE : $value");
                    setState(() {
                      celebration_subscribe = value;
                    });
                    fetch();
                  },
                ),
              ),
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.02,
              ),
              ListTile(
                  leading: Text(
                    "Frequency",
                    style: TextStyle(
                        fontSize: Utils(context).getMediaHeight() * 0.025),
                  ),
                  trailing: DropdownButton<String>(
                    value: frequency,
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
                        frequency = newValue;
                      });
                      fetch();
                    },
                    items: <String>[
                      'once- 14 days before',
                      'Once a week',
                      'Once a month'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.02,
              ),
              Divider(
                height: 0.08,
              ),
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.02,
              ),
              ListTile(
                leading: Text(
                  "Chat -",
                  style: TextStyle(
                      fontSize: Utils(context).getMediaHeight() * 0.025),
                ),
                title: Text(
                  "${chatToggleStatus ? "on" : "off"}",
                  style: TextStyle(
                      fontSize: Utils(context).getMediaHeight() * 0.025),
                ),
                trailing: CustomSwitch(
                  activeColor: Colors.blue,
                  value: chatToggleStatus,
                  onChanged: (value) {
                    print("VALUE : $value");
                    setState(() {
                      chatToggleStatus = value;
                    });
                    fetch();
                  },
                ),
              ),
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.02,
              ),
              ListTile(
                  leading: Text(
                    "Message Frequency",
                    style: TextStyle(
                        fontSize: Utils(context).getMediaHeight() * 0.025),
                  ),
                  trailing: DropdownButton<String>(
                    value: msgFrequency,
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
                        msgFrequency = newValue;
                      });
                      fetch();
                    },
                    items: <String>[
                      'anytime',
                      'Once a week',
                      'Once a month',
                      'ones in a week'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.02,
              ),
              Divider(
                height: 0.08,
              ),
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.02,
              ),
              ListTile(
                  leading: Text(
                    "Date Nights",
                    style: TextStyle(
                        fontSize: Utils(context).getMediaHeight() * 0.025),
                  ),
                  trailing: DropdownButton<String>(
                    value: dateNights,
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
                        dateNights = newValue;
                      });
                      fetch();
                    },
                    items: <String>[
                      'every 3 week',
                      'one in week',
                      'every week',
                      'anytime'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.02,
              ),
              Divider(
                height: 0.08,
              ),
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.02,
              ),
              ListTile(
                  leading: Text(
                    "Questionnaire",
                    style: TextStyle(
                        fontSize: Utils(context).getMediaHeight() * 0.025),
                  ),
                  trailing: DropdownButton<String>(
                    value: questionnaire,
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
                        questionnaire = newValue;
                      });
                      fetch();
                    },
                    items: <String>['weekly', 'monthly', 'daily', 'yearly']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.02,
              ),
              Divider(
                height: 0.08,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
