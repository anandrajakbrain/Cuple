import 'dart:convert';
import 'dart:io';

import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/listContainer.dart';
import 'package:cuple_app/configuration/APIs.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/notificationsListsResponse.dart';
import 'package:cuple_app/model/verifyOTPResponse.dart';
import 'package:cuple_app/screens/updateUserResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';
import 'notificationListScreen.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  User updateUser;
  UpdateUserResponse updateUserResponse;
  DateTime selectedDate = DateTime.now();
  TextEditingController dateInputController = new TextEditingController();
  File _image;
  final picker = ImagePicker();
  String gender;

  Future<void> _selectDate(BuildContext context, String type) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1967, 8),
        lastDate: DateTime(2121, 1));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        if (type == 'dob') {
          dateInputController.text = DateFormat("MMM d,y").format(picked);
          dobController.text = DateFormat("MMM d,y").format(picked);
          dob = DateFormat("y-MM-d").format(picked);
        } else if (type == "anniversary") {
          marriageAnniversary.text = DateFormat("y-MM-d").format(picked);
        } else if (type == "love Anniversary") {
          loveAnniversary.text = DateFormat("y-MM-d").format(picked);
        }
      });
  }

  Future getImage({ImageSource imageSource}) async {
    final pickedFile = await picker.getImage(source: imageSource);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No Image Selected');
      }
    });
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController marriageAnniversary = TextEditingController();
  TextEditingController loveAnniversary = TextEditingController();
  TextEditingController firstNameController= TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  var name = "";
  var email = "";
  var phone = "";
  var dob = "";
  var firstName, lastName, state = "";

  fetch() async {
    UpdateUserResponse _updateUserResponse = await Plugs(context)
        .updateUserDetailsWithFormData(
            userDetails.id.toString(),
            name,
            email,
            phone,
            dob,
            _image,
            marriageAnniversary.text.toString(),
            loveAnniversary.text.toString(),
            gender,
            firstName,
            lastName,
            state);

    setState(() {
      updateUserResponse = _updateUserResponse;
      if (updateUserResponse != null) {
        if (updateUserResponse.success == true) {
          updateUserLocal();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          Utils(context).showMessage(
              title: "Error",
              child: Text("${updateUserResponse.message}"),
              isCancel: true);
        }
      } else {
        Utils(context).showMessage(
            title: "Error",
            child: Text("Something Went Wrong"),
            isCancel: true);
      }
    });
  }

  updateUserLocal() async {
    SharedPreferences prf = await SharedPreferences.getInstance();
    // print("Update User Data");
    // print(updateUserResponse.data.toJson());
    prf.setString("user", jsonEncode(updateUserResponse.data));
    setState(() {
      userDetails = updateUserResponse.data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      nameController.text = userDetails.name;
      firstNameController.text = userDetails.firstName??"";
      lastNameController.text = userDetails.lastName??"";
      stateController.text = userDetails.state??"";
      emailController.text = userDetails.email;
      mobileController.text = userDetails.phone;
      dobController.text = userDetails.dob;
      name = userDetails.name;
      email = userDetails.email;
      phone = userDetails.phone;
      firstName = userDetails.firstName??"";
      lastName = userDetails.lastName??"";
      state = userDetails.state??"";
      dob = userDetails.dob;
      marriageAnniversary.text = userDetails.anniversaryDate;
      loveAnniversary.text = userDetails.firstDate;
      gender = userDetails.gender;
    });
    //Future.delayed(Duration(seconds: 2)).then((value) => fetch(1));
  }

  @override
  Widget build(BuildContext context) {
    print("User Pickture: ${userDetails.picture}");
    return Scaffold(
      backgroundColor: APP_PRIMARY_COLOR,
      appBar: AppBar(
        leading: CustomBackButton(),
        backgroundColor: APP_BAR_COLOR,
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationsListScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: APP_BAR_COLOR,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: APP_PRIMARY_COLOR,
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.17,
                          width: MediaQuery.of(context).size.height * 0.17,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0XFF5E08B3),
                                Color(0XFFE556EB),
                              ]),
                              shape: BoxShape.circle),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height * 0.1),
                              child: _image != null
                                  ? Image.file(
                                      _image,
                                      fit: BoxFit.cover,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                    )
                                  : userDetails.picture != "0"
                                      ? Image.network(
                                          userDetails.uploaded != null
                                              ? APP_ASSET_BASE_URL +
                                                  userDetails.picture
                                              : userDetails.picture,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              "assets/profile_user.jpg",
                                              fit: BoxFit.cover,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.15,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.15,
                                            );
                                          },
                                        )
                                      : Image.asset(
                                          "assets/profile_user.jpg",
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                        ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Color(0XFF1A93EE),
                                      Color(0XFF6F34DD)
                                    ]),
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: IconButton(
                                      onPressed: () async {
                                        getImage(
                                            imageSource: ImageSource.gallery);
                                      },
                                      icon: Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                        size:
                                            MediaQuery.of(context).size.height *
                                                0.025,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: Utils(context).getMediaHeight() * 0.035)),
                TextFormField(
                  controller: firstNameController,
                  onChanged: (val) {
                    setState(() {
                      firstName = val;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: ' First Name',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 1))),
                ), Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.035),
                ),
                TextFormField(
                  controller: lastNameController,
                  onChanged: (val) {
                    setState(() {
                      lastName = val;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: 'Last Name',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 1))),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.035),
                ),
                TextFormField(
                  controller: emailController,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 1))),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.035),
                ),
                TextFormField(
                  controller: mobileController,
                  onChanged: (val) {
                    setState(() {
                      phone = val;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 1))),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.035),
                ),
                InkWell(
                  onTap: () {
                    _selectDate(context, 'dob');
                  },
                  child: Container(
                    child: TextFormField(
                      enabled: false,
                      controller: dobController,
                      onChanged: (val) {
                        setState(() {
                          dob = val;
                        });
                      },
                      decoration: InputDecoration(
                          labelText: 'Birth Date',
                          labelStyle: TextStyle(color: Colors.grey),
                          hintText: "yyyy-MM-dd",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey,
                                  style: BorderStyle.solid,
                                  width: 1))),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.035),
                ),
                DropdownButtonFormField(
                  value: gender,
                  items: ["Male", "Female"]
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  decoration: InputDecoration(
                    labelText: "Gender",
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
                  onChanged: (text) {
                    setState(() {
                      gender = text;
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.035),
                ),
                /*   InkWell(
                  onTap: () {
                    _selectDate(context, 'anniversary');
                  },
                  child: Container(
                    child: TextFormField(
                      enabled: false,
                      controller: marriageAnniversary,
                      onChanged: (val) {
                        setState(() {
                          dob = val;
                        });
                      },
                      decoration: InputDecoration(
                          labelText: 'Marriage Anniversary',
                          labelStyle: TextStyle(color: Colors.grey),
                          hintText: "yyyy-MM-dd",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey,
                                  style: BorderStyle.solid,
                                  width: 1))),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.035),
                ),
                InkWell(
                  onTap: () {
                    _selectDate(context, "love Anniversary");
                  },
                  child: Container(
                    child: TextFormField(
                      enabled: false,
                      controller: loveAnniversary,
                      onChanged: (val) {
                        setState(() {
                          dob = val;
                        });
                      },
                      decoration: InputDecoration(
                          labelText: 'Love Anniversary',
                          labelStyle: TextStyle(color: Colors.grey),
                          hintText: "yyyy-MM-dd",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey,
                                  style: BorderStyle.solid,
                                  width: 1))),
                    ),
                  ),
                ),*/
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.055),
                ),
                GestureDetector(
                  onTap: () {
                    if (phone == "00000000" || phone == null) {
                      Utils(context).showMessage(
                          title: "Update your phone no",
                          child: Text("You did'nt update your phone no yet "),
                          handler: () {
                            Navigator.pop(context);
                          },
                          isCancel: true);
                    } else {
                      fetch();
                    }
                  },
                  child: Container(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.02),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0XFF1A93EE), Color(0XFF6F34DD)]),
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "SAVE",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
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
}
