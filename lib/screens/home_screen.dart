import 'dart:convert';

import 'package:circle_bottom_navigation/circle_bottom_navigation.dart';
import 'package:circle_bottom_navigation/widgets/tab_data.dart';
import 'package:cuple_app/componets/appBarActionButton.dart';
import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/customMenuButton.dart';
import 'package:cuple_app/componets/customMenuDrawer.dart';
import 'package:cuple_app/componets/friendRequestCard.dart';
import 'package:cuple_app/componets/ideasCardContainer.dart';
import 'package:cuple_app/componets/noInterNetConnectionScreen.dart';
import 'package:cuple_app/componets/noRecordFoundScreen.dart';
import 'package:cuple_app/componets/reminderCard.dart';
import 'package:cuple_app/configuration/APIs.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/createNewReminderResponse.dart';
import 'package:cuple_app/model/getPartnerRequestResponse.dart';
import 'package:cuple_app/model/getUserPartnerDetailsResponse.dart';
import 'package:cuple_app/model/ideasListResponse.dart';
import 'package:cuple_app/model/listUserReminderResponse.dart';
import 'package:cuple_app/model/notificationsListsResponse.dart';
import 'package:cuple_app/model/remindersListsResponse.dart';
import 'package:cuple_app/model/settingsResponse.dart';
import 'package:cuple_app/model/suggesiontypeListsResponse.dart';
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
import 'package:cuple_app/screens/searchPartnerScreen.dart';
import 'package:cuple_app/screens/settings_screen.dart';
import 'package:cuple_app/screens/tipsDetailScreen.dart';
import 'package:cuple_app/screens/tipsListScreen.dart';
import 'package:cuple_app/screens/userFavoriteScreen.dart';
import 'package:cuple_app/screens/userProfile.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:ff_navigation_bar/ff_navigation_bar_item.dart';
import 'package:ff_navigation_bar/ff_navigation_bar_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'ideasDetailsScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _title = "Cuple";
  int selectedIndex = 0;
  Widget controlWidget;
  ListUserReminderResponse remindersListsResponse;
  IdeasListResponse ideasListResponse;
  TipsListResponse tipsListResponse;
  ListUserReminderResponse listUserReminderResponse;
  GetPartnerRequestResponse getPartnerRequestResponse;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1)).then((value) {
      getuserDetails().then((value) {
        getApis();
        fetchReminders();
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

  fetchReminders() async {
    Utils(context).checkInternet().then((value) async {
      if (value == true) {
        ListUserReminderResponse _listUserReminderResponse =
            await Plugs(context)
                .listUserReminderList(userId: userDetails.id.toString());

        setState(() {
          listUserReminderResponse = _listUserReminderResponse;
        });
      } else {
        Utils(context).showAlert(
            context: context,
            title: "",
            child: Container(
                height: 250, width: 150, child: NoInternetConnectionScreen()),
            handler: () {
              Navigator.pop(context);
              fetchReminders();
            },
            isCancel: false);
      }
    });
  }

  getSuggestionTypeList() async {
    SuggesiontypeListsResponse _suggesiontypeListsResponse =
        await Plugs(context).getSuggestionType();
    setState(() {
      suggesiontypeListsResponse = _suggesiontypeListsResponse;
    });
  }

  getSettings() async {
    SettingsResponse _settingsResponse =
        await Plugs(context).getSettings(userDetails.id.toString());
    setState(() {
      userSettings = _settingsResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(userDetails.name);
    if (userDetails != null) {
      if (userDetails.status == "Active") {
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
                    child: Image.asset("assets/logo.png",fit: BoxFit.contain,),
                  ),
                ),
              ),
              backgroundColor: APP_BAR_COLOR,
              title: Text(
                "$_title",
                style: TextStyle(color: Colors.black),
              ),
              elevation: 0,
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationsListScreen())).then((value) => fetch(userDetails.id.toString()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Positioned(


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
                        notificationsListsResponse!=null?notificationsListsResponse.data.where((element) => element.readable=="1").toList().length>0?  Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red

                            ),
                            child: Text(notificationsListsResponse!=null?notificationsListsResponse.data.where((element) => element.readable=="1").toList().length.toString():''),
                          ),
                        ):SizedBox():SizedBox(),
                      ],
                    ),
                  ),
                )
              ],
            ),
            drawer: CustomMenuDrawer(
              userDetails,
              handler: () {
                getApis();
              },
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
                print(userDetails.id);
                // if(index == 2){
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => ChatScreen()));
                // }
                setState(() {
                  selectedIndex = index;
                  controlWidget = getWidget(index: selectedIndex);
                  if (selectedIndex == 1) {
                    if (partnerData != null) {
                      _title =
                          "${partnerData.name.toString().split(' ').first}";
                    } else {
                      _title = "Favorites";
                    }
                  } else if (selectedIndex == 3) {
                    _title = "Profile";
                  } else if (selectedIndex == 0) {
                    _title = "Cuple";
                  }
                });
              },
              items: [
                FFNavigationBarItem(
                  iconData: Icons.home_outlined,
                  label: 'Cuple',
                ),
                FFNavigationBarItem(

                  iconData: Icons.favorite_border,
                  label: partnerData != null
                      ? partnerData.name.toString().split(' ').first
                      : "Favorites",
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
      } else {
        return Scaffold(
          backgroundColor: APP_BAR_COLOR,
          body: Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "User not verified yet by Admin \n please Wait ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: Utils(context).getMediaWidth() * 0.05),
                  ),
                  SizedBox(
                    height: Utils(context).getMediaHeight() * 0.06,
                  ),
                  InkWell(
                    onTap: () {
                      Utils(context).logout();
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
                            'Log Out',
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
    } else {
      return Scaffold(
        body: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
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
                      "Welcome ${userDetails != null ? userDetails.firstName ?? userDetails.name : ""}!",
                      style: TextStyle(
                        fontSize: Utils(context).getMediaWidth() * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: EdgeInsets.only(left: 10.0),
                    child: partnerData != null
                        ? Text(
                            "${partnerData != null ? partnerData.firstName ?? partnerData.name : ""} Partner",
                            style: TextStyle(
                              fontSize: Utils(context).getMediaWidth() * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SearchPartnerScreen()));
                            },
                            child: Text(
                              "Connect your partner",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    margin: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Best Date Ideas",
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
                          )).then((value) => getApis());
                    },
                    child: Row(
                      children: [
                        Container(
                          //padding: const EdgeInsets.all(8.0),
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
                  itemCount: ideasListResponse != null
                      ? ideasListResponse.data.length > 3
                          ? 3
                          : ideasListResponse.data.length
                      : 0,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, index) {
                    return GestureDetector(
                      onTap: () {
                        /*Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebViewIdea(
                                  ideasListResponse.data[index].link),
                            ));*/
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>IdeasDetailsScreen(ideasData:  ideasListResponse.data[index]),
                            ));


                      },
                      child: Container(
                        padding: EdgeInsets.all(
                            Utils(context).getMediaHeight() * 0.02),
                        width: Utils(context).getMediaWidth() * 0.8,
                        margin: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0XFFf6feff),
                              Color(0XFFf6feff),
                            ]),
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                color: Colors.grey[300],
                                blurRadius: 1,
                              )
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                
                                padding:
                                    EdgeInsets.only(top: 5.0, bottom: 5.0),
                                child: ideasListResponse.data[index].image !=
                                        null
                                    ? Image.network(
                                        "${APP_ASSET_BASE_URL + ideasListResponse.data[index].image}",
                                        // fit: BoxFit.cover,
                                        height:
                                            Utils(context).getMediaHeight() *
                                                0.18,
                                        //width: 1,
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace stackTrace) {
                                          return Image.asset(
                                            "assets/ideaImg2.png",
                                            // fit: BoxFit.cover,
                                            height: Utils(context)
                                                    .getMediaHeight() *
                                                0.18,
                                            //width: 1,
                                          );
                                        },
                                      )
                                    : Image.asset(
                                        "assets/ideaImg2.png",
                                        // fit: BoxFit.cover,
                                        height:
                                            Utils(context).getMediaHeight() *
                                                0.18,
                                        //width: 1,
                                      ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                              ideasListResponse.data[index].name,// "Best ${suggesiontypeListsResponse != null ? suggesiontypeListsResponse.data.where((element) => element.id == 1).first.name : 'Date Ideas'}",
                                    style: TextStyle(
                                        color: Color(0XFF333333),//Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            Utils(context).getMediaWidth() *
                                                0.035),
                                    softWrap: true,
                                    maxLines: 1,
                                  ),
                                  SizedBox(
                                    height:
                                        Utils(context).getMediaHeight() * 0.02,
                                  ),
                                  Text(
                                    Utils(context)
                                        .parseHtmlString(ideasListResponse
                                            .data[index].content
                                            .toString())
                                        .toString(),
                                    style: TextStyle(
                                        // color: Colors.white,
                                        color: Color(0XFF333333),
                                        fontSize:
                                            Utils(context).getMediaWidth() *
                                                0.03),
                                    softWrap: true,
                                    maxLines: 3,
                                    overflow: TextOverflow.fade,
                                  ),
                                  SizedBox(
                                    height:
                                        Utils(context).getMediaHeight() * 0.02,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      try {
                                        var body = {
                                          "user_id": userDetails.id.toString(),
                                          "suggesion_id": ideasListResponse
                                              .data[index].id
                                              .toString(),
                                        };
                                        Utils(context).showProgressLoader();
                                        http.Response response =
                                            await http.post(SUGGESSION_BOOK,
                                                headers:
                                                    Plugs(context).getHeaders(),
                                                body: body);
                                        if (response.statusCode == 200) {
                                          print(response.body);
                                          Navigator.pop(context);
                                          Utils(context).showMessage(
                                              title: "Success",
                                              child: Text(jsonDecode(
                                                  response.body)['message']));
                                          // return CreateNewReminderResponse.fromJson(
                                          //     jsonDecode(response.body));
                                        } else {
                                          throw Exception(jsonDecode(
                                              response.body)['message']);
                                        }
                                      } catch (e, s) {
                                        Navigator.pop(context);
                                        print(s);
                                        Utils(context).showMessage(
                                            title: "error",
                                            child: Text(e.toString()));
                                      }
                                    },
                                    child: Container(
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
                                                Utils(context).getMediaWidth() *
                                                    0.03),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
              ),
             /* Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: EdgeInsets.only(left: 10.0),
                    child: Text(
                      " ${partnerData != null ? "Next Date to remember for " + partnerData.name : ""}",
                      style: TextStyle(
                        fontSize: Utils(context).getMediaWidth() * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),*/
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      margin: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Dates to Remember",
                        style: TextStyle(
                          fontSize: Utils(context).getMediaWidth() * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 15),
                          ),
                          icon: Icon(Icons.add_circle_outline_outlined),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CreateNewReminder())); //.then((value) => fetch());
                          },
                          label: const Text('Create New'),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ReminderListScreen()))
                                .then((value) => getApis());
                          },
                          child: Row(
                            children: [
                              FittedBox(
                                child: Container(
                                  //padding: const EdgeInsets.all(8.0),
                                  margin: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "See All",
                                    style: TextStyle(
                                        fontSize:
                                            Utils(context).getMediaWidth() *
                                                0.035,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.blue),
                                  ),
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
                  ),
                ],
              ),
              Container(
                height: Utils(context).getMediaHeight() * 0.26,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: remindersListsResponse != null
                        ? remindersListsResponse.data.length
                        : 0,
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
                          ],
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: SvgPicture.asset(
                                "assets/hearts.svg", fit: BoxFit.cover,
                                color: Colors.red[100],
                                //semanticsLabel: 'A red up arrow'
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${remindersListsResponse.data[index].customize_name ?? remindersListsResponse.data[index].name}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Utils(context).getMediaWidth() *
                                          0.03),
                                ),
                                SizedBox(
                                  height:
                                      Utils(context).getMediaHeight() * 0.02,
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
                                    DateFormat("MMM d,y").format(
                                      DateTime.parse(remindersListsResponse
                                          .data[index].date),
                                    ),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            Utils(context).getMediaWidth() *
                                                0.03),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      Utils(context).getMediaHeight() * 0.02,
                                ),
                                Text(
                                  getInDays(
                                              inputDate: remindersListsResponse
                                                  .data[index].date)
                                          .toString() +
                                      "day(s)",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Utils(context).getMediaWidth() *
                                          0.03),
                                ),
                                SizedBox(
                                  height:
                                      Utils(context).getMediaHeight() * 0.02,
                                ),
                                Text(
                                  "To Celebrate ${remindersListsResponse.data[index].name}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Utils(context).getMediaWidth() *
                                          0.03),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FunnyCardListScreen(
                            partnerName: partnerData != null
                                ? partnerData.name
                                : 'Partner'),
                      )).then((value) => getApis());
                },
                child: Container(
                  width: Utils(context).getMediaWidth() * 0.90,
                  // padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0XFF663DDF),
                      Color(0XFF2487EC),
                    ]),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: FittedBox(
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
                        Padding(

                          padding: const EdgeInsets.only(right:8.0),
                          child: Text(
                            "Browse amazing cards for ${partnerData != null ? partnerData.firstName ?? '' : 'Partner'}",
                            softWrap: true,
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TipsListScreen(),
                      )).then((value) => getApis());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      margin: EdgeInsets.only(left: 10.0),
                      child: Text(
                        suggesiontypeListsResponse != null
                            ? suggesiontypeListsResponse.data
                                .where((element) => element.id == 2)
                                .first
                                .name
                            : 'Love Tips',
                        style: TextStyle(
                          fontSize: Utils(context).getMediaWidth() * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          //padding: const EdgeInsets.all(8.0),
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
                  itemCount: tipsListResponse != null
                      ? tipsListResponse.data.length > 3
                          ? 3
                          : tipsListResponse.data.length
                      : 0,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, index) {
                    return GestureDetector(
                      onTap: () {
                        /*Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebViewIdea(
                                  tipsListResponse.data[index].link),
                            ));*/
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TipsDetailScreen(tipsData: tipsListResponse.data[index]),
                            ));



                      },
                      child: Container(
                        padding: EdgeInsets.all(
                            Utils(context).getMediaHeight() * 0.02),
                        width: Utils(context).getMediaWidth() * 0.8,
                        margin: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0XFFf6feff),
                              Color(0XFFf6feff),
                              /*Color(0XFF9250E7),
                              Color(0XFFC55E3E),*/

                            ]),
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                color: Colors.grey[300],
                                blurRadius: 1,
                              )
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                padding:
                                    EdgeInsets.only(top: 10.0, bottom: 8.0),
                                child: tipsListResponse.data[index].image !=
                                        null
                                    ? Image.network(
                                        "${APP_ASSET_BASE_URL + tipsListResponse.data[index].image}",
                                        // fit: BoxFit.cover,
                                        height:
                                            Utils(context).getMediaHeight() *
                                                0.14,
                                        //width: 1,
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace stackTrace) {
                                          return Image.asset(
                                            "assets/ideaImg2.png",
                                            // fit: BoxFit.cover,
                                            height: Utils(context)
                                                    .getMediaHeight() *
                                                0.14,
                                            //width: 1,
                                          );
                                        },
                                      )
                                    : Image.asset(
                                        "assets/ideaImg2.png",
                                        // fit: BoxFit.cover,
                                        height:
                                            Utils(context).getMediaHeight() *
                                                0.14,
                                        //width: 1,
                                      ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    tipsListResponse.data[index].name,
                                    // "Best Date Tips",
                                    style: TextStyle(
                                        // color: Colors.white,
                                        color: Color(0XFF333333),
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            Utils(context).getMediaWidth() *
                                                0.035),
                                    softWrap: true,
                                    maxLines: 1,
                                  ),
                                  SizedBox(
                                    height:
                                        Utils(context).getMediaHeight() * 0.02,
                                  ),
                                  Text(
                                    Utils(context)
                                        .parseHtmlString(tipsListResponse
                                            .data[index].content
                                            .toString())
                                        .toString(),
                                    style: TextStyle(

                                        color: Color(0XFF333333),
                                        // color: Colors.white,
                                        fontSize:
                                            Utils(context).getMediaWidth() *
                                                0.03),
                                    softWrap: true,
                                    maxLines: 3,
                                    overflow: TextOverflow.fade,
                                  ),
                                  SizedBox(
                                    height:
                                        Utils(context).getMediaHeight() * 0.02,
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
                                      "KNOW MORE",
                                      style: TextStyle(
                                          color: Color(0XFFB05983),
                                          fontSize:
                                              Utils(context).getMediaWidth() *
                                                  0.03),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            /*  InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyWishList(),
                      )).then((value) => getApis());
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
                                builder: (context) => PartnerWishlist(
                                    partnerName: partnerData != null
                                        ? partnerData.name
                                        : 'Partner'),
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
                              Expanded(
                                child: Text(
                                  "${partnerData != null ? partnerData.name : 'Partner'} Wish List",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),*/
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyWishList(),
                      )).then((value) => getApis());
                },
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  width: Utils(context).getMediaWidth() * 0.90,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0XFF2487EC),
                      Color(0XFF663DDF),
                    ]),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
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
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PartnerWishlist(
                            partnerName: partnerData != null
                                ? partnerData.name
                                : 'Partner'),
                      ));
                },
                child: Container(
                  width: Utils(context).getMediaWidth() * 0.90,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0XFF2487EC),
                      Color(0XFF663DDF),
                    ]),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      Expanded(
                        child: Text(
                          "${partnerData != null ? partnerData.name : 'Partner'} Wish List",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            WebViewIdea("https://www.herwishlist.com/"),
                      ));
                },
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  width: Utils(context).getMediaWidth() * 0.90,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0XFF663DDF),
                      Color(0XFF2487EC),
                    ]),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          "Cuple Gift Suggestions for ${partnerData != null ? partnerData.name : ''} ",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
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
                    top: MediaQuery.of(context).size.height * 0.10),
                child: Card(
                  child: Container(
                    // width: double.infinity,
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
                                top: MediaQuery.of(context).size.height * 0.1)),
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
                          /*padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.height * 0.02),*/
                          padding: EdgeInsets.all(2.0),
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
                                  /*Text(
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
                                              0.02)),*/
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
                                  Text(
                                    "State",
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
                                    ":\t\t${userDetails.phone ?? ''}",
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
                                  /*Text(
                                    ":\t\t${userDetails.gender ?? ""}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.02)),*/
                                  Text(
                                    ":\t\t${userDetails.dob??""}",
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
                                  /* Text(
                                    ":\t\t${userDetails.state.substring(0,5) ?? ""}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),  */
                                  FittedBox(
                                    child: Text(
                                      ":\t\t${userDetails.state ?? ""}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300),
                                    ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    child: Container(
                      child: Text(
                        " Dates to Remember",
                        style: TextStyle(
                          fontSize: Utils(context).getMediaWidth() * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // TextButton.icon(onPressed: (){}, icon: Icon(Icons.add_circle_outline_outlined), label: Text("Create New")),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 15),
                      ),
                      icon: Icon(Icons.add_circle_outline_outlined),
                      onPressed: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateNewReminder()))
                            .then((value) {
                          // getApis();
                          fetchReminders();
                        }); //.then((value) => fetch());
                      },
                      label: const Text('Create New'),
                    ),
                  ),
                ],
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
                    child: Container(
                      height: Utils(context).getMediaHeight() * 0.2,
                      width: Utils(context).getMediaWidth() * 0.80,
                      child: ListView.builder(
                        controller: ScrollController(),
                        shrinkWrap: true,
                        itemCount: listUserReminderResponse != null
                            ? listUserReminderResponse.data.length
                            : 0,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.height *
                                            0.03),
                                child: FittedBox(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.02)),
                                          Text(
                                            "${listUserReminderResponse.data[index].name}",
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.02)),
                                          FittedBox(
                                            child: Text(
                                              ":\t\t${listUserReminderResponse.data[index].date}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            ),
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
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02)),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()))
                      .then((value) => getApis());
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
                  gradient: LinearGradient(colors: [
                    Color(0XFF5E08B3),
                    Color(0XFFE556EB),
                  ]),
                  shape: BoxShape.circle),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.1),
                  child: userDetails.picture != "0"
                      ? Image.network(
                          userDetails.uploaded != null
                              ? APP_ASSET_BASE_URL + userDetails.picture
                              : userDetails.picture,
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.height * 0.15,
                          errorBuilder: (context, error, straktress) {
                            return Image.asset(
                              "assets/profile_user.jpg",
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.height * 0.15,
                            );
                          },
                        )
                      : Image.asset(
                          "assets/profile_user.jpg",
                          fit: BoxFit.cover,
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
        return UserFavoriteScreen();
        break;
      case 2:
        if (partnerData != null) {
          return ChatScreen(
            isbottom: true,
          );
        } else {
          return Container(
              height: Utils(context).getMediaHeight() * 0.70,
              child: Center(
                  child: NoRecordFoundScreen(
                msg: "Please Select Partner First",
              )));
        }

        break;
      case 3:
        return displayProfileWidget(context);
        break;
      default:
        return displayHomeWidget(context);
    }
    ;
  }

  getApis() async {
    Utils(context).checkInternet().then((value) async {
      if (value == true) {
        // await getSuggestionTypeList();
        await getReminder();
        await getIdeasList();
        await getTipsList();
        await getpartnerDetails();
        await getfrendRequest();
        await fetchReminders();
        await getSettings();
        await fetch(userDetails.id);
      } else {
        Utils(context).showAlert(
            context: context,
            title: "",
            child: Container(
                height: 250, width: 150, child: NoInternetConnectionScreen()),
            handler: () {
              Navigator.pop(context);
              getApis();
            },
            isCancel: false);
      }
    });
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
      IdeasListResponse _ideasListResponse =
          await Plugs(context).getIdeasList(type: "Ideas");
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
      TipsListResponse _tipsListResponse =
          await Plugs(context).getTipsList(type: "tips");
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

  getpartnerDetails() async {
    try {
      if (userDetails.partnerid != 0) {
        GetUserPartnerDetailsResponse _getUserPartnerDetailsResponse =
            await Plugs(context)
                .getUserPartnerDetails(Userid: userDetails.id.toString());
        if (_getUserPartnerDetailsResponse.success == true) {
          setState(() {
            partnerData = _getUserPartnerDetailsResponse.data;
          });
        }
      }
    } catch (e) {
      Utils(context).showMessage(
        title: "Error",
        child: Text("${e}"),
      );
      ;
    }
  }

  getfrendRequest() async {
    String friendname;

    GetPartnerRequestResponse _getPartnerRequestResponse =
        await Plugs(context).getFriendRequest();
    print("Request Element");
    setState(() {
      getPartnerRequestResponse = _getPartnerRequestResponse;
      getPartnerRequestResponseGlobal = _getPartnerRequestResponse;
    });

    print("Partner Requester Condition True or false ");
    print(jsonEncode(getPartnerRequestResponse.date));
    print(_getPartnerRequestResponse.date
        .where((element) =>
            element.invitationStatus == "Accepted" &&
            // element.toId == userDetails.id &&
            element.adminStatus == "Appprove")
        .isEmpty);

    if (_getPartnerRequestResponse.date
            .where((element) =>
                element.invitationStatus == "Pending" &&
                element.toId == userDetails.id)
            .isEmpty ==
        false) {
      FriendRequestData friendRequestData = _getPartnerRequestResponse.date
          .where((element) =>
              element.invitationStatus == "Pending" &&
              element.toId == userDetails.id)
          .first;
      /*Utils(context).showMessage(
        title: "$friendname send Friend Request",
        child: FriendRequestCard(
          friendRequestData: friendRequestData,
          callback: (value){
            setState(() {
              friendname=value;
            });
          },
        ),
      );*/
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return FriendRequestCard(
              friendRequestData: getPartnerRequestResponseGlobal.date.first,
              callback: (value) {
                setState(() {
                  friendname = value;
                });
              },
            );
          });
    } else if (_getPartnerRequestResponse.date
            .where((element) =>
                element.invitationStatus == "Accepted" &&
                // element.toId == userDetails.id &&
                element.adminStatus == "Appprove")
            .isEmpty ==
        false) {
      print("Partner Data Inserting");
      if (userDetails.partnerid == 0) {
        FriendRequestData friendRequestData = _getPartnerRequestResponse.date
            .where((element) =>
                element.invitationStatus == "Accepted" &&
                // element.toId == userDetails.id &&
                element.adminStatus == "Appprove")
            .first;
        SharedPreferences prf = await SharedPreferences.getInstance();
        userDetails.partnerid = friendRequestData.fromId == userDetails.id
            ? friendRequestData.toId
            : friendRequestData.fromId;
        prf.setString("user", jsonEncode(userDetails));

        await getpartnerDetails();
      }
    }
  }
  NotificationsListsResponse notificationsListsResponse;
  fetch(var id) async {
    Utils(context).checkInternet().then((value) async {
      if (value == true) {
        NotificationsListsResponse _notificationsListsResponse =
        await Plugs(context).getNotificationList(id, name: "");

        setState(() {
          notificationsListsResponse = _notificationsListsResponse;
        });
      
      } else {
        Utils(context).showAlert(
            context: context,
            title: "",
            child: Container(
                height: 250, width: 150, child: NoInternetConnectionScreen()),
            handler: () {
              Navigator.pop(context);
              fetch(userDetails.id.toString());
            },
            isCancel: false);
      }
    });
  }
}
