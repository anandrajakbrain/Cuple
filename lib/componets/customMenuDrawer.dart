import 'package:cuple_app/configuration/APIs.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/verifyOTPResponse.dart';
import 'package:cuple_app/screens/login.dart';
import 'package:cuple_app/screens/myWishList.dart';
import 'package:cuple_app/screens/partnerWishList.dart';
import 'package:cuple_app/screens/settings_screen.dart';
import 'package:cuple_app/screens/userProfile.dart';
import 'package:flutter/material.dart';

class CustomMenuDrawer extends StatefulWidget {
  final User userDetails;
  CustomMenuDrawer(this.userDetails);
  @override
  _CustomMenuDrawerState createState() => _CustomMenuDrawerState();
}

class _CustomMenuDrawerState extends State<CustomMenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                  colors: [Color(0XFF1A93EE), Color(0XFF6F34DD)]),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Row(
                    children: [
                      Container(
                        height: Utils(context).getMediaHeight() * 0.11,
                        width: Utils(context).getMediaHeight() * 0.11,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(colors: [
                              Color(0XFF5E08B3),
                              Color(0XFFE556EB),
                            ])),
                        child: userDetails.picture != "0"
                            ? Image.network(
                          APP_ASSET_BASE_URL + userDetails.picture,
                          fit: BoxFit.cover,
                          // height: MediaQuery.of(context).size.height * 0.15,
                          // width: MediaQuery.of(context).size.height * 0.15,
                          errorBuilder: (context, error, straktress) {
                            return Image.asset(
                              "assets/profile_user.jpg",
                              fit: BoxFit.cover,
                              // height: MediaQuery.of(context).size.height * 0.15,
                              // width: MediaQuery.of(context).size.height * 0.15,
                            );
                          },
                        )
                            : Image.asset(
                          "assets/profile_user.jpg",
                          fit: BoxFit.cover,
                          // height: MediaQuery.of(context).size.height * 0.15,
                          // width: MediaQuery.of(context).size.height * 0.15,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: Utils(context).getMediaWidth() * 0.03)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${userDetails != null ? userDetails.name ?? "" : ""}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize:
                                Utils(context).getMediaHeight() * 0.024),
                          ),
                          Text(
                            '${userDetails != null ? userDetails.email ?? "" : ""}',
                            overflow: TextOverflow.ellipsis,

                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              //fontSize: Utils(context).getMediaHeight() * 0.024
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserProfile()));
            },
            child: Padding(
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
                            border: Border.all(color: Colors.grey[400])),
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
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyWishList()));
            },
            child: Padding(
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
                            border: Border.all(color: Colors.grey[400])),
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
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PartnerWishlist(
                            partnerName: partnerData!=null?partnerData.name:'',
                          )));
            },
            child: Padding(
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
                            border: Border.all(color: Colors.grey[400])),
                        child: Icon(
                          Icons.star_border,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Text("${partnerData!=null?partnerData.name:'Partner'} Wish List")
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsScreen(widget.userDetails)));
            },
            child: Padding(
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
                            border: Border.all(color: Colors.grey[400])),
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
                          border: Border.all(color: Colors.grey[400])),
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
          InkWell(
            onTap: () {

              Utils(context).logout();
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Padding(
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
                            border: Border.all(color: Colors.black)),
                        child: Icon(
                          Icons.logout,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      "Logout",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
