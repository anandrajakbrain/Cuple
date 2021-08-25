import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/listContainer.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/notificationsListsResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'home_screen.dart';
import 'notificationListScreen.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() =>
      _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  NotificationsListsResponse notificationsListsResponse;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  var name = "";
  var email = "";
  var mobile = "";
  var dob = "";

  fetch(var id) async {
    NotificationsListsResponse _notificationsListsResponse =
    await Plugs(context).getNotificationList(id, name: "");

    setState(() {
      notificationsListsResponse=_notificationsListsResponse;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Future.delayed(Duration(seconds: 2)).then((value) => fetch(1));
  }

  @override
  Widget build(BuildContext context) {
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
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0XFF5E08B3),
                                    Color(0XFFE556EB),
                                  ]),
                              shape: BoxShape.circle
                          ),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.1),
                              child: Image.asset("assets/profile_user.jpg",fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.height * 0.15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [Color(0XFF1A93EE), Color(0XFF6F34DD)]),
                                  shape: BoxShape.circle
                                ),
                                child: Center(
                                  child: IconButton(onPressed: (){},
                                      icon: Icon(Icons.camera_alt, color: Colors.white,
                                      size: MediaQuery.of(context).size.height * 0.025,)
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: Utils(context).getMediaHeight() * 0.035)),
                TextFormField(
                  controller: nameController,
                  onChanged: (val){
                    setState(() {
                      name = val;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(
                          color: Colors.grey
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 1
                          )
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.035),
                ),
                TextFormField(
                  controller: nameController,
                  onChanged: (val){
                    setState(() {
                      name = val;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          color: Colors.grey
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 1
                          )
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.035),
                ),
                TextFormField(
                  controller: nameController,
                  onChanged: (val){
                    setState(() {
                      name = val;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      labelStyle: TextStyle(
                          color: Colors.grey
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 1
                          )
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.035),
                ),
                TextFormField(
                  controller: nameController,
                  onChanged: (val){
                    setState(() {
                      name = val;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: 'Birth Date',
                      labelStyle: TextStyle(
                          color: Colors.grey
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 1
                          )
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.055),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                  },
                  child: Container(
                    child: Container(
                      width: double.infinity,
                      padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
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
                                color: Colors.white, fontWeight: FontWeight.w300),
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
