import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/favouritesItemCardContainer.dart';
import 'package:cuple_app/componets/ideasCardContainer.dart';
import 'package:cuple_app/componets/noInterNetConnectionScreen.dart';
import 'package:cuple_app/componets/noRecordFoundScreen.dart';
import 'package:cuple_app/componets/reminderCard.dart';
import 'package:cuple_app/componets/tipsCardContainer.dart';
import 'package:cuple_app/componets/tutorialListContainer.dart';
import 'package:cuple_app/componets/wishlistContainer.dart';
import 'package:cuple_app/configuration/APIs.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/ideasListResponse.dart';
import 'package:cuple_app/model/listUserReminderResponse.dart';
import 'package:cuple_app/model/reminder_type_response.dart';
import 'package:cuple_app/model/tipsListResponse.dart';
import 'package:cuple_app/model/tutorialsListsResponse.dart';
import 'package:cuple_app/model/userFavouritesList.dart';
import 'package:cuple_app/model/userWishListResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class UserFavoriteScreen extends StatefulWidget {
  @override
  _UserFavoriteScreenState createState() => _UserFavoriteScreenState();
}

class _UserFavoriteScreenState extends State<UserFavoriteScreen> {
  UserFavouritesList userFavouritesList;
  ListUserReminderResponse remindersForPartnerListsResponse;
  ListUserReminderResponse listUserReminderResponse;
  RemindersTypeResponse remindersTypeResponse;
  RemindersTypeData remindersTypeData;
  List<String> reminderTypeList = List();
  var reminderIdsObj = {};
  UserWishListResponse userWishListResponse;
  IdeasListResponse ideasListResponse;
  TipsListResponse tipsListResponse;

  getReminderType() async {
    setState(() {
      remindersTypeResponse = null;
      remindersTypeData = null;
    });
    RemindersTypeResponse _remindersListsResponse =
    await Plugs(context).getreminderType();
    setState(() {
      remindersTypeResponse = _remindersListsResponse;
      for(int i = 0; i < remindersTypeResponse.data.length; i++){print(remindersTypeResponse.data[i].name.toString());
      reminderTypeList.add(remindersTypeResponse.data[i].name);
      print(remindersTypeResponse.data[i].name);
      print("reminder ${remindersTypeResponse.data[i].id}");
      reminderIdsObj[remindersTypeResponse.data[i].name] = remindersTypeResponse.data[i].name;
      }
    });
    print("reminder IDS Obj");
    print(reminderIdsObj);
  }

  fetch() async {
    Utils(context).checkInternet().then((value) async {
      if(value==true){
        ListUserReminderResponse _listUserReminderResponse = await Plugs(context)
            .listUserReminderList(userId: partnerData.id.toString());

        setState(() {
          listUserReminderResponse = _listUserReminderResponse;
        });
        print("List User Reminder");
        print(_listUserReminderResponse.toJson());
      }
      else {
        Utils(context).showAlert(
            context: context,
            title: "",
            child: Container(
                height: 250, width: 150, child: NoInternetConnectionScreen()),
            handler: () {
              Navigator.pop(context);
              fetch();
            },
            isCancel: false);
      }
    });
  }

  fetchPartnerWishList() async {
    Utils(context).checkInternet().then((value) async {
      if(value==true){
        if(partnerData!=null) {
          UserWishListResponse _userWishListResponse =
          await Plugs(context).getPartnerWishList(
              partnerID: partnerData.id.toString());

          setState(() {
            userWishListResponse = _userWishListResponse;
          });
        }
      }
      else {
        Utils(context).showAlert(
            context: context,
            title: "",
            child: Container(
                height: 250, width: 150, child: NoInternetConnectionScreen()),
            handler: () {
              Navigator.pop(context);
              fetchPartnerWishList();
            },
            isCancel: false);
      }
    });
  }

  fetchIdeasList() async {
    Utils(context).checkInternet().then((value) async {
      if(value==true){
        IdeasListResponse _ideasListResponse = await Plugs(context).getIdeasList();
        setState(() {
          ideasListResponse = _ideasListResponse;
        });
      }
      else {
        Utils(context).showAlert(
            context: context,
            title: "",
            child: Container(
                height: 250, width: 150, child: NoInternetConnectionScreen()),
            handler: () {
              Navigator.pop(context);
              fetchIdeasList();
            },
            isCancel: false);
      }
    });
  }

  fetchLoveTips() async {
    Utils(context).checkInternet().then((value) async {
      if(value==true){

        TipsListResponse _tipsListResponse =
        await Plugs(context).getTipsList(type: "tips");
        setState(() {
          tipsListResponse=_tipsListResponse;
        });
      }
      else {
        Utils(context).showAlert(
            context: context,
            title: "",
            child: Container(
                height: 250, width: 150, child: NoInternetConnectionScreen()),
            handler: () {
              Navigator.pop(context);
              fetch();
            },
            isCancel: false);
      }
    });
  }


  /*fetch(var id) async {
    Utils(context).checkInternet().then((value) async {
      if (value == true) {
        if (partnerData != null) {
          UserFavouritesList _userFavouritesList = await Plugs(context)
              .getUserFavouritesList(
                  partnerID:
                      partnerData != null ? partnerData.id.toString() : '');

          setState(() {
            userFavouritesList = _userFavouritesList;
          });
        }
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
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 0))
        .then((value) {
      fetch();
      getReminderType();
      fetchPartnerWishList();
      fetchIdeasList();
      fetchLoveTips();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Utils(context).getMediaHeight() * 0.80,
      color: APP_BAR_COLOR,
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: partnerData != null
            ? Column(
          children: [
            partnerData.picture != "0"
                ? Image.network(
              partnerData.uploaded != null
                  ? APP_ASSET_BASE_URL + partnerData.picture
                  : partnerData.picture,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.025)),
                Text(
                  "${partnerData.name}",
                  style: TextStyle(
                      fontWeight: FontWeight.w500),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top:
                        MediaQuery.of(context).size.height * 0.01)),
                Text(
                  "${partnerData.email}",
                  style: TextStyle(
                      fontWeight: FontWeight.w400),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top:
                        MediaQuery.of(context).size.height * 0.02)),
                /* Divider(
                  thickness: 0.2,
                  color: Colors.white,
                ),*/
                Padding(
                    padding: EdgeInsets.only(
                        top:
                        MediaQuery.of(context).size.height * 0.00)),
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
                                //color: Colors.white,
                                fontWeight: FontWeight.w400),
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
                                //color: Colors.white,
                                fontWeight: FontWeight.w400),
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
                            ":\t\t${partnerData.phone ?? ''}",
                            style: TextStyle(
                                //color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.02)),
                          Text(
                            ":\t\t${partnerData.dob}",
                            style: TextStyle(
                                //color: Colors.white,
                                fontWeight: FontWeight.w400),
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
            Divider(
              thickness: 0.2,
              color: Colors.black,
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02)),
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  //padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  margin: EdgeInsets.only(left: 10.0),
                  child: Text(
                    /*suggesiontypeListsResponse != null
                        ? suggesiontypeListsResponse.data
                        .where((element) => element.id == 3)
                        .first
                        .name
                        :*/'Dates to Remember',
                    style: TextStyle(
                      fontSize: Utils(context).getMediaWidth() * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02)),
            ListView.builder(
              shrinkWrap: true,
              controller: ScrollController(),
              itemCount: reminderTypeList.length,
              itemBuilder: (BuildContext context, int index){
                return Column(
                  children: [
                    Text(
                      "${reminderTypeList[index]}",
                      style: TextStyle(
                        fontSize: Utils(context).getMediaWidth() * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: Utils(context).getMediaHeight() * 0.3,
                      child: getReminder(context, reminderTypeList[index]),
                    )
                  ],
                );
              },
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02)),
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  //padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  margin: EdgeInsets.only(left: 10.0),
                  child: Text(
                    /*suggesiontypeListsResponse != null
                        ? suggesiontypeListsResponse.data
                        .where((element) => element.id == 3)
                        .first
                        .name
                        :*/ "${partnerData.name}'s Wish List",
                    style: TextStyle(
                      fontSize: Utils(context).getMediaWidth() * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: APP_BAR_COLOR,
              padding: EdgeInsets.all(8.0),
              child: Center(
                child:userWishListResponse!=null?userWishListResponse.data.length>0?ListView.builder(
                    itemCount: userWishListResponse.data.length,
                    shrinkWrap: true,
                    controller: ScrollController(),
                    itemBuilder: (context, index) {
                      return WishListContainer(isEven: true,isDelete: false,userWishListData: userWishListResponse.data[index],);
                    }):Container(
                  child: Center(child: SvgPicture.asset("assets/hearts.svg",color: Color(0XFFD947E0),),),
                ):NoRecordFoundScreen(
                  icon: FontAwesomeIcons.fileDownload,
                  msg: "Please Wait",
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02)),
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  //padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  margin: EdgeInsets.only(left: 10.0),
                  child: Text(
                    /*suggesiontypeListsResponse != null
                        ? suggesiontypeListsResponse.data
                        .where((element) => element.id == 3)
                        .first
                        .name
                        :*/ "Best Date Ideas for ${partnerData.name}",
                    style: TextStyle(
                      fontSize: Utils(context).getMediaWidth() * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01)),
            Container(
              child: ideasListResponse != null
                  ? ideasListResponse.data.length > 0
                  ? GridView.builder(
                shrinkWrap: true,
                  controller: ScrollController(),
                  itemCount: ideasListResponse != null
                      ? ideasListResponse.data.length
                      : 0,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, index) {
                    return  IdeasCardContainer(
                        ideasData: ideasListResponse.data[index]);// Container();
                  })
                  : NoRecordFoundScreen(
                msg: "No Record Found",
              )
                  : NoRecordFoundScreen(
                icon: FontAwesomeIcons.fileDownload,
                msg: "Please Wait",
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.04)),
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  //padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  margin: EdgeInsets.only(left: 10.0),
                  child: Text(
                    /*suggesiontypeListsResponse != null
                        ? suggesiontypeListsResponse.data
                        .where((element) => element.id == 3)
                        .first
                        .name
                        :*/ "Love Tips for ${partnerData.name}",
                    style: TextStyle(
                      fontSize: Utils(context).getMediaWidth() * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01)),
            Container(
              child: tipsListResponse!=null?tipsListResponse.data.length>0?
              GridView.builder(
                  itemCount: tipsListResponse!=null?tipsListResponse.data.length:0,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  controller: ScrollController(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, index) {
                    return  TipsCardContainer(tipsData: tipsListResponse.data[index]);// : Container();
                  }):NoRecordFoundScreen():NoRecordFoundScreen(icon: FontAwesomeIcons.fileDownload,msg: "Please Wait",
              ),
            ),
          ],
        )
            : NoRecordFoundScreen(
                icon: FontAwesomeIcons.fileDownload,
                msg: partnerData!=null?"Please Wait":"You Didn't Have Partner Yet",
              ),
      ),
    );
  }

  getReminder(BuildContext context, var name){
    return listUserReminderResponse!=null? listUserReminderResponse.data
        .where((element) => element.type.toString() == reminderIdsObj[name].toString())
        .toList()
        .length>0?  Container(
      //height: Utils(context).getMediaHeight() * 0.28,
      child: GridView.builder(
          shrinkWrap: true,
          controller: ScrollController(),
          itemCount:listUserReminderResponse!=null? listUserReminderResponse.data
              .where((element) => element.type.toString() == reminderIdsObj[name].toString())
              .toList()
              .length:0,
          // physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: Utils(context).getMediaHeight() * 0.8 /
                Utils(context).getMediaWidth(),
            // childAspectRatio:10/10,
          ),
          itemBuilder: (BuildContext context, index) {
            return ReminderCard(
              userListReminderData: listUserReminderResponse.data
                  .where(
                      (element) => element.type.toString() == reminderIdsObj[name].toString())
                  .toList()[index],
              handlerCall: (){
                fetch();
              },
            );
          }),
    ):NoRecordFoundScreen():NoRecordFoundScreen(
      icon: FontAwesomeIcons.fileDownload,
      msg: "Please Wait",
    );
  }
}
