import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/listContainer.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/getMsgResponse.dart';
import 'package:cuple_app/model/notificationsListsResponse.dart';
import 'package:cuple_app/model/sendMsgResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'notificationListScreen.dart';

class ChatScreen extends StatefulWidget {
  bool isbottom;

  ChatScreen({@required this.isbottom = true});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  GetMsgResponse getMsgResponse;
  String msgStr;
  TextEditingController msgController = new TextEditingController();
  var _formKey = GlobalKey<FormState>();

  fetch() async {
    GetMsgResponse _getMsgResponse =
        await Plugs(context).getmsg(Userid: userDetails.id.toString());

    setState(() {
      getMsgResponse = _getMsgResponse;
    });
  }

  List msgs = ["Hello!", "Hey, Whats up", "....."];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((value) => fetch());
  }

  @override
  Widget build(BuildContext context) {
    return widget.isbottom == true
        ? Container(
            height: Utils(context).getMediaHeight() * 0.80,
            color: APP_BAR_COLOR,
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\tChat with Your Partner",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Utils(context).getMediaHeight() * 0.024),
                  ),
                  // Padding(padding: EdgeInsets.only(top: Utils(context).getMediaHeight() * 0.035)),
                  Container(
                    height: Utils(context).getMediaHeight() * 0.65,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: getMsgResponse != null
                            ? getMsgResponse.data.length
                            : 0,
                        itemBuilder: (context, index) {
                          return Container(
                            width: Utils(context).getMediaWidth() * 0.7,
                            padding: EdgeInsets.all(
                                Utils(context).getMediaHeight() * 0.01),
                            child: Row(
                              mainAxisAlignment: getMsgResponse.data[index].toId.toString()==userDetails.id.toString()
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.end,
                              children: [
                                getMsgResponse.data[index].toId.toString()==userDetails.id.toString()
                                    ? Flexible(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          child: Image.asset(
                                            "assets/profile_user.jpg",
                                            fit: BoxFit.cover,
                                            height: 50.0,
                                            width: 50.0,
                                          ),
                                        ),
                                      )
                                    : Container(),
                                getMsgResponse.data[index].toId.toString()==userDetails.id.toString()
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            left: Utils(context)
                                                    .getMediaHeight() *
                                                0.005),
                                      )
                                    : Container(),
                                Column(
                                  crossAxisAlignment:getMsgResponse.data[index].toId.toString()==userDetails.id.toString()
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            color: getMsgResponse.data[index].toId.toString()==userDetails.id.toString()
                                                ? Colors.purpleAccent
                                                : Colors.deepPurpleAccent,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: getMsgResponse.data[index].toId.toString()==userDetails.id.toString()
                                                    ? Radius.circular(0)
                                                    : Radius.circular(10),
                                                bottomRight: getMsgResponse.data[index].toId.toString()==userDetails.id.toString()
                                                    ? Radius.circular(10)
                                                    : Radius.circular(0))),
                                        padding: EdgeInsets.all(
                                            Utils(context).getMediaHeight() *
                                                0.015),
                                        //width: Utils(context).getMediaWidth() * 0.6,
                                        child: Row(
                                          children: [
                                            Text(
                                              "${getMsgResponse.data[index].msg}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: Utils(context)
                                                          .getMediaHeight() *
                                                      0.022),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: Utils(context)
                                                          .getMediaHeight() *
                                                      0.015),
                                            )
                                          ],
                                        )),
                                    Text(
                                      "${DateFormat().format(DateTime.parse(getMsgResponse.data[index].createdAt))}",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize:
                                              Utils(context).getMediaHeight() *
                                                  0.015),
                                    ),
                                  ],
                                ),
                                getMsgResponse.data[index].toId.toString()!=userDetails.id.toString()
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            left: Utils(context)
                                                    .getMediaHeight() *
                                                0.015),
                                      )
                                    : Container(),
                                getMsgResponse.data[index].toId.toString()!=userDetails.id.toString()
                                    ? Flexible(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          child: Image.asset(
                                            "assets/profile_user.jpg",
                                            fit: BoxFit.cover,
                                            height: 50.0,
                                            width: 50.0,
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          );
                        }),
                  ),

                  Form(
                    key: _formKey,
                    child: Container(
                      width: Utils(context).getMediaWidth() * 0.95,
                      height: Utils(context).getMediaHeight() * 0.08,
                      child: TextFormField(
                        controller: msgController,
                        decoration: new InputDecoration(
                            // labelText: "type",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                              borderSide: new BorderSide(),
                            ),
                            suffix: IconButton(
                                icon: Icon(
                                  Icons.send,
                                  color: Color(0XFF6045E0),
                                ),
                                onPressed: () {
                                  if(_formKey.currentState.validate()){
                                    sendMsg();
                                  }
                                })
                            //fillColor: Colors.green
                            ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: CustomBackButton(),
              backgroundColor: APP_BAR_COLOR,
              title: Text(
                "Love Diary",
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
            body: Container(
              color: APP_BAR_COLOR,
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\tChat with Your Partner",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Utils(context).getMediaHeight() * 0.024),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: Utils(context).getMediaHeight() * 0.035)),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount:  getMsgResponse.data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: Utils(context).getMediaWidth() * 0.7,
                            padding: EdgeInsets.all(
                                Utils(context).getMediaHeight() * 0.01),
                            child: Row(
                              mainAxisAlignment:  getMsgResponse.data[index].toId==userDetails.id
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.end,
                              children: [
                                index % 2 == 0
                                    ? Flexible(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          child: Image.asset(
                                            "assets/profile_user.jpg",
                                            fit: BoxFit.cover,
                                            height: 50.0,
                                            width: 50.0,
                                          ),
                                        ),
                                      )
                                    : Container(),
                                getMsgResponse.data[index].toId==userDetails.id
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            left: Utils(context)
                                                    .getMediaHeight() *
                                                0.005),
                                      )
                                    : Container(),
                                Column(
                                  crossAxisAlignment:  getMsgResponse.data[index].toId==userDetails.id
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            color:  getMsgResponse.data[index].toId==userDetails.id
                                                ? Colors.purpleAccent
                                                : Colors.deepPurpleAccent,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft:  getMsgResponse.data[index].toId==userDetails.id
                                                    ? Radius.circular(0)
                                                    : Radius.circular(10),
                                                bottomRight:  getMsgResponse.data[index].toId==userDetails.id
                                                    ? Radius.circular(10)
                                                    : Radius.circular(0))),
                                        padding: EdgeInsets.all(
                                            Utils(context).getMediaHeight() *
                                                0.015),
                                        //width: Utils(context).getMediaWidth() * 0.6,
                                        child: Row(
                                          children: [
                                            Text(
                                              "${ getMsgResponse.data[index].msg}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: Utils(context)
                                                          .getMediaHeight() *
                                                      0.022),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: Utils(context)
                                                          .getMediaHeight() *
                                                      0.015),
                                            )
                                          ],
                                        )),
                                    Text(
                                      "${DateFormat().format(DateTime.parse( getMsgResponse.data[index].createdAt))}",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize:
                                              Utils(context).getMediaHeight() *
                                                  0.015),
                                    ),
                                  ],
                                ),
                                getMsgResponse.data[index].toId!=userDetails.id
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            left: Utils(context)
                                                    .getMediaHeight() *
                                                0.015),
                                      )
                                    : Container(),
                                getMsgResponse.data[index].toId!=userDetails.id
                                    ? Flexible(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          child: Image.asset(
                                            "assets/profile_user.jpg",
                                            fit: BoxFit.cover,
                                            height: 50.0,
                                            width: 50.0,
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          );
                        }),
                    Container(),
                  ],
                ),
              ),
            ),
          );
  }

  sendMsg() async {
    try {
      SendMsgResponse sendMsgResponse =
          await Plugs(context).sendMsg(to_id: partnerData.id.toString(), MSG: msgController.text);
      setState(() {
        msgController.text = "";
      });
      fetch();
    } catch (e, s) {
      print(s);
      print(e);
    }
  }
}
