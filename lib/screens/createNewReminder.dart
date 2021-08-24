import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/customMenuButton.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/createNewReminderResponse.dart';
import 'package:cuple_app/model/remindersListsResponse.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateNewReminder extends StatefulWidget {
  @override
  _CreateNewReminderState createState() => _CreateNewReminderState();
}

class _CreateNewReminderState extends State<CreateNewReminder> {
  List<String> categoryType = [
    'Anniversary',
    'Celebration',
  ];
  var _formKey = GlobalKey<FormState>();
  String reminderTypeVal, reminderNameVal;
  TextEditingController dateInputController = new TextEditingController();
  RemindersListsResponse remindersListsResponse;
  RemindersListData remindersListData;
  DateTime selectedDate = DateTime.now();

  getReminderName(String type) async {
    setState(() {
      remindersListsResponse = null;
      remindersListData = null;
    });
    RemindersListsResponse _remindersListsResponse =
    await Plugs(context).getreminderTypeList(type: type);
    setState(() {
      remindersListsResponse = _remindersListsResponse;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateInputController.text = DateFormat("MMM d,y").format(picked);
      });
  }

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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: Utils(context).getMediaHeight() * 0.06,
                ),
                DropdownButtonFormField(
                  value: reminderTypeVal,
                  items: categoryType
                      .map(
                        (e) =>
                        DropdownMenuItem(
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
                    getReminderName(value);
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Please Select Reminder Type";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: Utils(context).getMediaHeight() * 0.03,
                ),
                remindersListsResponse != null
                    ? DropdownButtonFormField(
                  // value: remindersListData,
                  items: remindersListsResponse.data
                      .map(
                        (e) =>
                        DropdownMenuItem(
                          child: Text(e.name),
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
                      remindersListData = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Please Select Reminder Name";
                    }
                    return null;
                  },
                )
                    : DropdownButtonFormField(
                  validator: (value) {
                    if (value == null) {
                      return "Please Select Reminder Name";
                    }
                    return null;
                  },
                  items: [],
                  decoration: InputDecoration(
                    labelText: "Reminder Name",
                    labelStyle: TextStyle(
                        fontSize: Utils(context).getMediaWidth() * 0.04),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: Utils(context).getMediaHeight() * 0.03,
                ),
                InkWell(
                  onTap: () {
                    print("Tap Work");
                    _selectDate(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      enabled: false,
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
                ),
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState.validate()) {
creteReminder();

                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerificationScreen()));
                    }
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
      ),
    );
  }
  void creteReminder()async {
    try {
      CreateNewReminderResponse createNewReminders = await Plugs(
          context).createNewReminder(category: reminderTypeVal,
          remindersListData: remindersListData,
          date: selectedDate.toString());
      Navigator.pop(context);


    }catch(e,s){
      Utils(context).showMessage(
        title: "Error",
        // temp=jsonDecode(source);
        child: Text("${e}"),
      );
    }
  }
}


