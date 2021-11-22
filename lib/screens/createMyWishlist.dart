import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/createNewReminderResponse.dart';
import 'package:cuple_app/model/regularResponse.dart';
import 'package:cuple_app/model/reminder_type_response.dart';
import 'package:cuple_app/model/remindersListsResponse.dart';
import 'package:cuple_app/model/userWishListResponse.dart';
import 'package:cuple_app/model/wishListTitleResponse.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateMyWishlist extends StatefulWidget {
  UserWishListData userWishListData;bool isEdit;
  final callback;
  CreateMyWishlist({this.userWishListData,this.isEdit=false,this.callback});
  @override
  _CreateMyWishlistState createState() => _CreateMyWishlistState();
}

class _CreateMyWishlistState extends State<CreateMyWishlist> {
  List<String> categoryType = [
    'Anniversary',
    'Celebration',
  ];
  var _formKey = GlobalKey<FormState>();
  WishListTitlesData wishListTitlesData;
  String reminderNameVal;
  TextEditingController dateInputController = new TextEditingController();
  RemindersListsResponse remindersListsResponse;
  RemindersListData remindersListData;
  DateTime selectedDate = DateTime.now();
  WishListTitleResponse wishListTitleResponse;
  String customREminderName;
TextEditingController descriptionController=new TextEditingController();
TextEditingController linkController=new TextEditingController();
  getWishListTitles() async {
    WishListTitleResponse _wishListTitleResponse =
    await Plugs(context).getWishListTitles();
    setState(() {
      wishListTitleResponse = _wishListTitleResponse;
    });
  }

  getReminderName(int type) async {
    setState(() {
      remindersListsResponse = null;
      remindersListData = null;
    });
    RemindersListsResponse _remindersListsResponse =
    await Plugs(context).getreminderTypeList();
    setState(() {
      remindersListsResponse = _remindersListsResponse;
    });
  }

  getApis()async{
    await getWishListTitles();
    if(widget.isEdit==true){
      await setOldData();
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((value) {
      getApis();

    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1969, 1, 1),
      // DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 25),
      helpText: "Select Reminder Date",
      errorFormatText: 'Enter valid Reminder date',
      errorInvalidText: 'Enter date in valid range',
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateInputController.text = DateFormat("MMM d,y").format(picked);
      });
  }
setOldData()async{

    setState(() {
      wishListTitlesData=wishListTitleResponse.data.where((element) => element.id==widget.userWishListData.titleId).first;
      descriptionController.text=widget.userWishListData.description;
      linkController.text=widget.userWishListData.link;
    });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text(
          "Create My Wish List",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: APP_BAR_COLOR,
        elevation: 0,
      ),
      body: Container(
        height: Utils(context).getMediaHeight(),
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: Utils(context).getMediaHeight() * 0.06,
                  ),
                  wishListTitleResponse != null
                      ? DropdownButtonFormField(
                    value: wishListTitlesData,
                    items: wishListTitleResponse.data
                        .map(
                          (e) => DropdownMenuItem(
                        child: Text(e.name),
                        value: e,
                      ),
                    )
                        .toList(),
                    decoration: InputDecoration(
                      labelText: "Wish List Title",
                      labelStyle: TextStyle(
                          fontSize: Utils(context).getMediaWidth() * 0.04),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        wishListTitlesData = value;
                      });

                    },
                    validator: (value) {
                      if (value == null) {
                        return "Please Select Wish list Title";
                      }
                      return null;
                    },
                  )
                      : DropdownButtonFormField(
                    // value: reminderTypeVal,
                    items: [],
                    decoration: InputDecoration(
                      labelText: "Wish list Title",
                      labelStyle: TextStyle(
                          fontSize: Utils(context).getMediaWidth() * 0.06),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      // setState(() {
                      //   reminderTypeVal = value;
                      // });
                      // getReminderName(reminderTypeVal.id);
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Please Select Wish list Title";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: Utils(context).getMediaHeight() * 0.03,
                  ),

                  SizedBox(
                    height: Utils(context).getMediaHeight() * 0.03,
                  ),
                  Container(
                    height: Utils(context).getMediaHeight()*0.20,
                    // padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      // keyboardType: widget.TxtInputType,
                      controller: descriptionController,
                      maxLines: null,
                      expands: true,

                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: "description (eg. Cooking Lessons- I love to learn new things to cook, and I want to do it together with you) ",
                        labelStyle: TextStyle(
                          fontSize: Utils(context).getMediaWidth() * 0.06,
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
                        if (value.isEmpty) {
                          return "! Please Enter Description ";
                        }

                        return null;
                      },
                      onChanged: (val) {
                        // setState(() {
                        //   customREminderName = val;
                        // });
                      },
                      /*onChanged: (val){
            if (_formkey.currentState.validate()) {
              print("Validated");
            }else{
              print("Not Validated");
            }
          },*/
                    ),
                  ),
                  SizedBox(
                    height: Utils(context).getMediaHeight() * 0.03,
                  ),
                  Container(
                    // padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      // keyboardType: widget.TxtInputType,
                      controller: linkController,
                      decoration: InputDecoration(
                        labelText: "Link (Optional)",
                        labelStyle: TextStyle(
                          fontSize: Utils(context).getMediaWidth() * 0.06,
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
                        // if (value.isEmpty) {
                        //   return "! Please tell Who are we celebrating?";
                        // }

                        return null;
                      },
                      onChanged: (val) {
                        // setState(() {
                        //   customREminderName = val;
                        // });
                      },
                      /*onChanged: (val){
            if (_formkey.currentState.validate()) {
              print("Validated");
            }else{
              print("Not Validated");
            }
          },*/
                    ),
                  ),
                 /* InkWell(
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
                  ),*/
                  SizedBox(
                    height: Utils(context).getMediaHeight() * 0.03,
                  ),
                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState.validate()) {
                        // creteReminder();
createMyWishList();
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
      ),
    );
  }

 void createMyWishList() async {
    try {
      print("description Text");
      print(descriptionController.text);
     RegularResponse regularResponse=await Plugs(context).addAndEditToWishList(
       titleId: wishListTitlesData.id.toString(),
       description: descriptionController.text,
       link: linkController.text,
        id: widget.isEdit==true?widget.userWishListData.id.toString():null,
     );

      Navigator.pop(context);
      widget.callback();
      // Navigator.pop(context);
    } catch (e, s) {
      print(s);
      Utils(context).showMessage(
        title: "Error",
        // temp=jsonDecode(source);
        child: Text("${e}"),
      );
    }
  }
}
