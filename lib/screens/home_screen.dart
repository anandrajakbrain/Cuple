import 'package:circle_bottom_navigation/circle_bottom_navigation.dart';
import 'package:circle_bottom_navigation/widgets/tab_data.dart';
import 'package:cuple_app/componets/appBarActionButton.dart';
import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/customMenuButton.dart';
import 'package:cuple_app/componets/reminderCard.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/screens/createNewReminder.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:ff_navigation_bar/ff_navigation_bar_item.dart';
import 'package:ff_navigation_bar/ff_navigation_bar_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            _scaffoldKey.currentState.openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
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
          )
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0XFF1A93EE),
                        Color(0XFF6F34DD)
                      ]
                  ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        height: Utils(context).getMediaHeight() * 0.11,
                        width: Utils(context).getMediaHeight() * 0.11,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                colors: [
                                  Color(0XFF5E08B3),
                                  Color(0XFFE556EB),
                                ]
                            )
                        ),
                        child: Center(
                          child: Text("Image", style: TextStyle(color: Colors.white),),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: Utils(context).getMediaWidth() * 0.03)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('John Doe',style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: Utils(context).getMediaHeight() * 0.024
                          ),),
                          Text('john@gmail.com',style: TextStyle(
                              color: Colors.white,
                            fontWeight: FontWeight.w300,
                              //fontSize: Utils(context).getMediaHeight() * 0.024
                          ),),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey[400])
                        ),
                        child: Icon(
                          Icons.account_circle_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Text("Profile")
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey[400])
                        ),
                        child: Icon(
                          Icons.star_border,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Text("My Wish List")
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey[400])
                        ),
                        child: Icon(
                          Icons.star_border,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Text("Jeny's Wish List")
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey[400])
                        ),
                        child: Icon(
                          Icons.settings,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Text("Settings")
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey[400])
                        ),
                        child: Icon(
                          Icons.card_giftcard,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Text("Greeting Card Subscription")
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black)
                        ),
                        child: Icon(
                          Icons.logout,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text("Logout",style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
          setState(() {
            selectedIndex = index;
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
        child: selectedIndex == 3 ? displayProfileWidget(context) : displayHomeWidget(context),
      )
    );
  }

  Widget displayHomeWidget(BuildContext context){
    return Container(
      height: Utils(context).getMediaHeight() * 0.81,
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
                      "Welcome John!",
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
                              fontSize: Utils(context).getMediaWidth() * 0.035,
                              fontWeight: FontWeight.w300,
                              color: Colors.blue
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_forward,color: Colors.blue,)
                    ],
                  ),
                ],
              ),
              Container(
                height: Utils(context).getMediaHeight() * 0.21,
                child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, index){
                    return Container(
                      padding: EdgeInsets.all(Utils(context).getMediaHeight() * 0.02),
                      width: Utils(context).getMediaWidth() * 0.8,
                      margin: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color(0XFFE556EB),
                                Color(0XFF5E08B3),
                              ]
                          ),
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
                            "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print,",
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
              Row(
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
                              fontSize: Utils(context).getMediaWidth() * 0.035,
                              fontWeight: FontWeight.w300,
                              color: Colors.blue
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_forward,color: Colors.blue,)
                    ],
                  ),
                ],
              ),
              Container(
                height: Utils(context).getMediaHeight() * 0.26,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: 4,
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
                              "Love Anniversary",
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
                                "June 28,2021",
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
                              "2 Days",
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
              Container(
                width: Utils(context).getMediaWidth() * 0.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0XFF663DDF),
                        Color(0XFF2487EC),
                      ]
                  ),
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
                            border: Border.all(color: Colors.white)
                        ),
                        child: Icon(
                          Icons.card_giftcard,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text("Funny Cards for Jeny", style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
              Row(
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
                              fontSize: Utils(context).getMediaWidth() * 0.035,
                              fontWeight: FontWeight.w300,
                              color: Colors.blue
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_forward,color: Colors.blue,)
                    ],
                  ),
                ],
              ),
              Container(
                height: Utils(context).getMediaHeight() * 0.21,
                child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, index){
                    return Container(
                      padding: EdgeInsets.all(Utils(context).getMediaHeight() * 0.02),
                      width: Utils(context).getMediaWidth() * 0.8,
                      margin: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color(0XFF9250E7),
                                Color(0XFFC55E3E),
                              ]
                          ),
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
                            "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print,",
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
              Padding(
                padding: EdgeInsets.all(Utils(context).getMediaHeight() * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Utils(context).getMediaWidth() * 0.45,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color(0XFF2487EC),
                              Color(0XFF663DDF),
                            ]
                        ),
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
                                  border: Border.all(color: Colors.white)
                              ),
                              child: Icon(
                                Icons.star_border,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text("My Wish List", style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),
                    Container(
                      width: Utils(context).getMediaWidth() * 0.45,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color(0XFF2487EC),
                              Color(0XFF663DDF),
                            ]
                        ),
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
                                  border: Border.all(color: Colors.white)
                              ),
                              child: Icon(
                                Icons.star_border,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text("Jeny's Wish List", style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: Utils(context).getMediaWidth() * 0.75,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0XFF663DDF),
                        Color(0XFF2487EC),
                      ]
                  ),
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
                            border: Border.all(color: Colors.white)
                        ),
                        child: Icon(
                          Icons.card_giftcard,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text("Couple Gift Suggestions for Jeny", style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget displayProfileWidget(BuildContext context){
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Utils(context).getMediaWidth() * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
                child: Card(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.03),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0XFFE556EB),
                          Color(0XFF5E08B3)
                        ]
                      )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08)),
                        Text("John Doe", style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                        ),),
                        Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01)),
                        Text("john@gmail.com", style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300
                        ),),
                        Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),
                        Divider(thickness: 0.2,color: Colors.white,),
                        Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.08),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Mobile No.",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),
                                  Text("Gender",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),
                                  Text("Birth Date",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(":\t\t01234567890",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),
                                  Text(":\t\tMale",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),
                                  Text(":\t\t13 Jun, 1994",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),
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
              Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),
              Container(
                child: Text(
                  " Anniversary",
                  style: TextStyle(
                    fontSize: Utils(context).getMediaWidth() * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0)),
              Container(
                child: Card(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.03),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color(0XFFE556EB),
                              Color(0XFF5E08B3)
                            ]
                        )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),
                                  Text("Marriage Anniversary",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),
                                  Text("Birth Date",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),
                                  Text(":\t\t13 Jun, 2014",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),
                                  Text(":\t\t13 Jun, 1994",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),
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
              Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),
              Container(
                child: Text(
                  " Celebration",
                  style: TextStyle(
                    fontSize: Utils(context).getMediaWidth() * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0)),
              Container(
                child: Card(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.03),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color(0XFFE556EB),
                              Color(0XFF5E08B3)
                            ]
                        )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),
                                  Text("Dog's Birthday",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),
                                  Text("Connors Birthday",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),
                                  Text(":\t\t13 Jun, 2014",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),
                                  Text(":\t\t13 Jun, 1994",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),
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
              Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01)),
              Container(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color(0XFF1A93EE),
                            Color(0XFF6F34DD)
                          ]
                      ),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("EDIT PROFILE",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                    ],
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
              height: Utils(context).getMediaHeight() * 0.16,
              width: Utils(context).getMediaHeight() * 0.16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [
                        Color(0XFF5E08B3),
                        Color(0XFFE556EB),
                      ]
                  )
              ),
              child: Center(
                child: Text("Image", style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        )
      ],
    );
  }
}
