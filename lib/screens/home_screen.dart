import 'dart:convert';

import 'package:circle_bottom_navigation/circle_bottom_navigation.dart';
import 'package:circle_bottom_navigation/widgets/tab_data.dart';
import 'package:cuple_app/componets/appBarActionButton.dart';
import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/customMenuButton.dart';
import 'package:cuple_app/componets/customMenuDrawer.dart';
import 'package:cuple_app/componets/reminderCard.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/ideasListResponse.dart';
import 'package:cuple_app/model/listUserReminderResponse.dart';
import 'package:cuple_app/model/remindersListsResponse.dart';
import 'package:cuple_app/model/tipsListResponse.dart';
import 'package:cuple_app/model/verifyOTPResponse.dart';
import 'package:cuple_app/screens/chat_screen.dart';
import 'package:cuple_app/screens/createNewReminder.dart';
import 'package:cuple_app/screens/edit_profile.dart';
import 'package:cuple_app/screens/funnycardListScreen.dart';
import 'package:cuple_app/screens/ideasListScreen.dart';
import 'package:cuple_app/screens/login.dart';
import 'package:cuple_app/screens/myWishList.dart';
import 'package:cuple_app/screens/notificationListScreen.dart';
import 'package:cuple_app/screens/partnerWishList.dart';
import 'package:cuple_app/screens/reminderListScreen.dart';
import 'package:cuple_app/screens/settings_screen.dart';
import 'package:cuple_app/screens/tipsListScreen.dart';
import 'package:cuple_app/screens/userProfile.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:ff_navigation_bar/ff_navigation_bar_item.dart';
import 'package:ff_navigation_bar/ff_navigation_bar_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
  Widget controlWidget;
  ListUserReminderResponse remindersListsResponse;
  IdeasListResponse ideasListResponse;
  TipsListResponse tipsListResponse;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((value){ getuserDetails().then((value){
      getApis();

    });




    });
  }

  getuserDetails() async {
    SharedPreferences prf = await SharedPreferences.getInstance();
    setState(() {
      userDetails = User.fromJson(jsonDecode(prf.getString("user")));
    });

    // prf.setString("user", jsonEncode(verifyOTPResponse.user));
  }

  @override
  Widget build(BuildContext context) {
    // print(userDetails.name);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              _scaffoldKey.currentState.openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
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
                  Icons.menu,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          backgroundColor: APP_BAR_COLOR,
          title: Text(
            "Home",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
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
        ),
        drawer: CustomMenuDrawer(userDetails),
        bottomNavigationBar: FFNavigationBar(
          theme: FFNavigationBarTheme(
            barBackgroundColor: Colors.white,
            selectedItemBorderColor: Color(0XFF1A93EE),
            selectedItemBackgroundColor: Color(0XFF1A93EE),
            selectedItemIconColor: Colors.white,
            selectedItemLabelColor: Colors.black,
          ),
          selectedIndex: selectedIndex,
          onSelectTab: (index) {
            if(index == 2){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatScreen()));
            }
            setState(() {
              selectedIndex = index;
              controlWidget = getWidget(index: selectedIndex);
            });
          },
          items: [
            FFNavigationBarItem(
              iconData: Icons.home_outlined,
              label: 'Home',
            ),
            FFNavigationBarItem(
              iconData: Icons.lightbulb_outline,
              label: 'Idea',
            ),
            FFNavigationBarItem(
              iconData: Icons.mail_outline_outlined,
              label: 'Message',
            ),
            FFNavigationBarItem(
              iconData: Icons.account_circle_outlined,
              label: 'Profile',
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: controlWidget ??
              displayHomeWidget(
                  context), //selectedIndex == 3 ? displayProfileWidget(context) : displayHomeWidget(context),
        ));
  }

  Widget displayHomeWidget(BuildContext context) {
    return Container(
      height: Utils(context).getMediaHeight() * 0.81,
      color: APP_BAR_COLOR,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Welcome ${userDetails != null ? userDetails.name ?? "" : ""}!",
                      style: TextStyle(
                        fontSize: Utils(context).getMediaWidth() * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                IdeasListScreen(isBottom: false),
                          ));
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "See All",
                            style: TextStyle(
                                fontSize:
                                    Utils(context).getMediaWidth() * 0.035,
                                fontWeight: FontWeight.w300,
                                color: Colors.blue),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: Utils(context).getMediaHeight() * 0.24,
                child: ListView.builder(
                  itemCount: ideasListResponse!=null?ideasListResponse.data.length:0,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, index) {
                    return Container(
                      padding: EdgeInsets.all(
                          Utils(context).getMediaHeight() * 0.02),
                      width: Utils(context).getMediaWidth() * 0.8,
                      margin: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0XFFE556EB),
                            Color(0XFF5E08B3),
                          ]),
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              color: Colors.grey[300],
                              blurRadius: 1,
                            )
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Best Date Ideas",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    Utils(context).getMediaWidth() * 0.035),
                          ),
                          SizedBox(
                            height: Utils(context).getMediaHeight() * 0.02,
                          ),
                          Text(
                            Utils(context).parseHtmlString(ideasListResponse.data[index].content.toString()).toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    Utils(context).getMediaWidth() * 0.03),
                          ),
                          SizedBox(
                            height: Utils(context).getMediaHeight() * 0.02,
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0XFF2487EC),
                                Color(0XFF663DDF),
                              ]),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              "BOOK FOR US",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      Utils(context).getMediaWidth() * 0.03),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReminderListScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Reminders",
                        style: TextStyle(
                          fontSize: Utils(context).getMediaWidth() * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "See All",
                            style: TextStyle(
                                fontSize:
                                    Utils(context).getMediaWidth() * 0.035,
                                fontWeight: FontWeight.w300,
                                color: Colors.blue),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: Utils(context).getMediaHeight() * 0.26,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: remindersListsResponse!=null?remindersListsResponse.data.length:0,
                    controller: ScrollController(),
                    // physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, index) {
                      return Container(
                        //height: Utils(context).getMediaHeight() * 0.3,
                        width: Utils(context).getMediaHeight() * 0.2,
                        margin: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                            gradient: REMINDER_CARD_COLOR_HOME,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                color: Colors.grey[300],
                                blurRadius: 1,
                              )
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${remindersListsResponse.data[index].name}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      Utils(context).getMediaWidth() * 0.03),
                            ),
                            SizedBox(
                              height: Utils(context).getMediaHeight() * 0.02,
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color(0XFF2487EC),
                                  Color(0XFF663DDF),
                                ]),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                  DateFormat("MMM d,y").format(DateTime.parse(remindersListsResponse.data[index].date),),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        Utils(context).getMediaWidth() * 0.03),
                              ),
                            ),
                            SizedBox(
                              height: Utils(context).getMediaHeight() * 0.02,
                            ),
                            Text(
                      "${DateTime.parse(remindersListsResponse.data[index].date).difference(DateTime.now()).inDays} days",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      Utils(context).getMediaWidth() * 0.03),
                            ),
                            SizedBox(
                              height: Utils(context).getMediaHeight() * 0.02,
                            ),
                            Text(
                              "To Celebrate Anniversary",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      Utils(context).getMediaWidth() * 0.03),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FunnyCardListScreen(partnerName: "Jenny's"),
                      ));
                },
                child: Container(
                  width: Utils(context).getMediaWidth() * 0.5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0XFF663DDF),
                      Color(0XFF2487EC),
                    ]),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          //padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white)),
                          child: Icon(
                            Icons.card_giftcard,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        "Funny Cards for Jeny",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TipsListScreen(),
                      ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Tips",
                        style: TextStyle(
                          fontSize: Utils(context).getMediaWidth() * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "See All",
                            style: TextStyle(
                                fontSize:
                                    Utils(context).getMediaWidth() * 0.035,
                                fontWeight: FontWeight.w300,
                                color: Colors.blue),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: Utils(context).getMediaHeight() * 0.24,
                child: ListView.builder(
                  itemCount: tipsListResponse!=null?tipsListResponse.data.length:0,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, index) {
                    return Container(
                      padding: EdgeInsets.all(
                          Utils(context).getMediaHeight() * 0.02),
                      width: Utils(context).getMediaWidth() * 0.8,
                      margin: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0XFF9250E7),
                            Color(0XFFC55E3E),
                          ]),
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              color: Colors.grey[300],
                              blurRadius: 1,
                            )
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Best Date Tips",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    Utils(context).getMediaWidth() * 0.035),
                          ),
                          SizedBox(
                            height: Utils(context).getMediaHeight() * 0.02,
                          ),
                          Text(
                            Utils(context).parseHtmlString(tipsListResponse.data[index].content.toString()).toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    Utils(context).getMediaWidth() * 0.03),
                          ),
                          SizedBox(
                            height: Utils(context).getMediaHeight() * 0.02,
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0XFFFAFAFA),
                                Color(0XFFFFFFFF),
                              ]),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              "KNOW MORE",
                              style: TextStyle(
                                  color: Color(0XFFB05983),
                                  fontSize:
                                      Utils(context).getMediaWidth() * 0.03),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyWishList(),
                      ));
                },
                child: Padding(
                  padding:
                      EdgeInsets.all(Utils(context).getMediaHeight() * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Utils(context).getMediaWidth() * 0.45,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0XFF2487EC),
                            Color(0XFF663DDF),
                          ]),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                //padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white)),
                                child: Icon(
                                  Icons.star_border,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              "My Wish List",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.02)),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PartnerWishlist(partnerName: "Jenny's"),
                              ));
                        },
                        child: Container(
                          width: Utils(context).getMediaWidth() * 0.45,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0XFF2487EC),
                              Color(0XFF663DDF),
                            ]),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  //padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white)),
                                  child: Icon(
                                    Icons.star_border,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                "Jeny's Wish List",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: Utils(context).getMediaWidth() * 0.75,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0XFF663DDF),
                    Color(0XFF2487EC),
                  ]),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        //padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white)),
                        child: Icon(
                          Icons.card_giftcard,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      "Couple Gift Suggestions for Jeny",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget displayProfileWidget(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Utils(context).getMediaWidth() * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.08),
                child: Card(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.height * 0.03),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0XFFE556EB), Color(0XFF5E08B3)])),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).size.height * 0.1)),
                        Text(
                          "${userDetails.name}",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).size.height * 0.01)),
                        Text(
                          "${userDetails.email}",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w300),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).size.height * 0.02)),
                        Divider(
                          thickness: 0.2,
                          color: Colors.white,
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).size.height * 0.02)),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.height * 0.08),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mobile No.",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02)),
                                  Text(
                                    "Gender",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02)),
                                  Text(
                                    "Birth Date",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ":\t\t${userDetails.phone}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02)),
                                  Text(
                                    ":\t\tMale",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02)),
                                  Text(
                                    ":\t\t${userDetails.dob}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02)),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02)),
              Container(
                child: Text(
                  " Anniversary",
                  style: TextStyle(
                    fontSize: Utils(context).getMediaWidth() * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.0)),
              Container(
                child: Card(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.height * 0.03),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0XFFE556EB), Color(0XFF5E08B3)])),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.height * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02)),
                                  Text(
                                    "Marriage Anniversary",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02)),
                                  Text(
                                    "Love Anniversary",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02)),
                                  Text(
                                    ":\t\t${userDetails.anniversaryDate}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02)),
                                  Text(
                                    ":\t\t${userDetails.firstDate}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02)),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02)),
              Container(
                child: Text(
                  " Celebration",
                  style: TextStyle(
                    fontSize: Utils(context).getMediaWidth() * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.0)),
              Container(
                child: Card(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.height * 0.03),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0XFFE556EB), Color(0XFF5E08B3)])),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.height * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02)),
                                  Text(
                                    "Dog's Birthday",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02)),
                                  Text(
                                    "Connors Birthday",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02)),
                                  Text(
                                    ":\t\t13 Jun, 2014",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02)),
                                  Text(
                                    ":\t\t13 Jun, 1994",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02)),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01)),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfile()));
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
                          "EDIT PROFILE",
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
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
          ],
        )
      ],
    );
  }

  Widget getWidget({int index}) {
    switch (index) {
      case 0:
        return displayHomeWidget(context);
        break;
      case 1:
        return IdeasListScreen(
          isBottom: true,
        );
        break;
      // case 2:return TipsListScreen();
      // break;
      case 3:
        return displayProfileWidget(context);
        break;
      default:
        return displayHomeWidget(context);
    }
    ;
  }


  getApis() async{
    await getReminder();
    await getIdeasList();
    await getTipsList();
  }
  getReminder() async {
    try {
      ListUserReminderResponse _remindersListsResponse = await Plugs(context)
          .listUserReminderList(userId: userDetails.id.toString());
      setState(() {
        remindersListsResponse = _remindersListsResponse;
      });
    } catch (e) {
      Utils(context).showMessage(
        title: "Error",
        child: Text("${e}"),
      );
      ;
    }
  }

  getIdeasList() async {
    try {
      IdeasListResponse _ideasListResponse = await Plugs(context).getIdeasList(type: "Ideas");
      setState(() {
        ideasListResponse = _ideasListResponse;
      });
    } catch (e) {
      Utils(context).showMessage(
        title: "Error",
        child: Text("${e}"),
      );
      ;
    }
  }
  getTipsList() async {
    try {
      TipsListResponse _tipsListResponse = await Plugs(context).getTipsList(type: "tips");
      setState(() {
        tipsListResponse = _tipsListResponse;
      });
    } catch (e) {
      Utils(context).showMessage(
        title: "Error",
        child: Text("${e}"),
      );
      ;
    }
  }
}