import 'dart:convert';

import 'package:cuple_app/configuration/APIs.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/getPartnerRequestResponse.dart';
import 'package:cuple_app/model/sendPartnerRequestResponse.dart';
import 'package:cuple_app/model/showUserResponse.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendRequestCard extends StatefulWidget {
  FriendRequestData friendRequestData;
  final callback;

  FriendRequestCard({this.friendRequestData, this.callback});

  @override
  _FriendRequestCardState createState() => _FriendRequestCardState();
}

class _FriendRequestCardState extends State<FriendRequestCard> {
  ShowUserResponse showUserResponse;

  fetch() async {
    ShowUserResponse _showUserResponse = await Plugs(context)
        .showUser(userID: widget.friendRequestData.fromId.toString());
    setState(() {
      showUserResponse = _showUserResponse;
    });
    widget.callback(_showUserResponse.data.name);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1)).then((value) => fetch());
  }

  @override
  Widget build(BuildContext context) {
    return showUserResponse != null
        ? AlertDialog(
            title: Text("${showUserResponse.data.name} send Friend Request"),
            content: Container(
              height: Utils(context).getMediaHeight() * 0.40,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(8.0),
                    width: Utils(context).getMediaWidth() * 0.20,
                    height: Utils(context).getMediaHeight() * 0.10,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      // borderRadius: BorderRadius.circular(50.0),
                      image: DecorationImage(
                        image: showUserResponse != null
                            ? showUserResponse.data.picture != "0"
                                ? NetworkImage(
                                    showUserResponse.data.uploaded != null
                                        ? APP_ASSET_BASE_URL +
                                            showUserResponse.data.picture
                                        : showUserResponse.data.picture,
                                  )
                                : AssetImage("assets/profile_user.jpg")
                            : AssetImage("assets/profile_user.jpg"),
                      ),
                    ),

                    // child: Image.asset("assets/profile_user.jpg",fit: BoxFit.contain),
                  ),
                  Text(
                    showUserResponse.data.name ?? '',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      actionRequest("accept");
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
                            'ACCEPT',
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
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      actionRequest("");
                    },
                    child: SizedBox(
                      width: Utils(context).getMediaWidth() * 0.80,
                      child: Container(
                        padding: EdgeInsets.all(14.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            border: Border.all(color: Color(0XFF1E8FED))),
                        child: Center(
                          child: Text(
                            'DECLINE',
                            style: TextStyle(
                              color: Color(0XFF1E8FED),
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
            ))
        : AlertDialog(
            content: Container(
              height: Utils(context).getMediaHeight() * 0.40,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
  }

  actionRequest(String type) async {
    if (type == "accept") {
      SendPartnerRequestResponse sendPartnerRequestResponse =
          await Plugs(context).acceptPartnerRequest(
              matchId: widget.friendRequestData.id.toString());
      Navigator.pop(context);
      Utils(context).showMessage(
          title: "Congratulations",
          child: Text(
            "Congratulations, you’re paired with ${partnerData.firstName ?? ''}. Now you can see the Dates they want to remember, gifts they want, experiences, places to travel to, romantic dates they want to go on, Love Tips they like",
          softWrap: true,

          ));

      setState(() {
        userDetails.partnerid = widget.friendRequestData.fromId;
      });
      Plugs(context).sendNotification(
          sendToUID: widget.friendRequestData.fromId.toString(),
          title: "Friend Request Accepted",
          msg:
              "Congratulations, you’re paired with ${partnerData.firstName ?? ''}. Now you can see the Dates they want to remember, gifts they want, "
              "experiences, places to travel to, romantic dates they want to go on, Love Tips they like…");
      SharedPreferences prf = await SharedPreferences.getInstance();
      // print("Update User Data");
      // print(updateUserResponse.data.toJson());
      prf.setString("user", jsonEncode(userDetails));
    } else {
      SendPartnerRequestResponse sendPartnerRequestResponse =
          await Plugs(context).cancelPartnerRequest(
              matchId: widget.friendRequestData.id.toString());
      Plugs(context).sendNotification(
          sendToUID: widget.friendRequestData.fromId.toString(),
          title: "Friend Request Canceled",
          msg: "${userDetails.name} Has Been Reject Your Friend Request.");
      Navigator.pop(context);
      Utils(context).showMessage(
          title: "", child: Text(sendPartnerRequestResponse.message));
    }
  }
}
