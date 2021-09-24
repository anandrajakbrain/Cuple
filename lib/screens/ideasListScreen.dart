import 'package:cuple_app/componets/appBarActionButton.dart';
import 'package:cuple_app/componets/customMenuButton.dart';
import 'package:cuple_app/componets/customMenuDrawer.dart';
import 'package:cuple_app/componets/hartScreen.dart';
import 'package:cuple_app/componets/ideasCardContainer.dart';
import 'package:cuple_app/componets/noInterNetConnectionScreen.dart';
import 'package:cuple_app/componets/noRecordFoundScreen.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/ideasListResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'notificationListScreen.dart';

class IdeasListScreen extends StatefulWidget {
  bool isBottom;

  IdeasListScreen({@required this.isBottom = false});

  @override
  _IdeasListScreenState createState() => _IdeasListScreenState();
}

class _IdeasListScreenState extends State<IdeasListScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  IdeasListResponse ideasListResponse;

  fetch() async {
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
              fetch();
            },
            isCancel: false);
      }


    });




  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1)).then((value) => fetch());
  }

  @override
  Widget build(BuildContext context) {
    return widget.isBottom
        ? SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              partnerData != null ? Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0XFF6341DF), Color(0XFF1E8FED)]),
            ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "${userDetails != null ? userDetails.name ?? "" : ""}",
                        style: TextStyle(
                          fontSize: Utils(context).getMediaWidth() * 0.04,
                          fontWeight: FontWeight.bold,
                            //color: Colors.white
                        ),
                      ),
                    ),
                    SvgPicture.asset("assets/hearts.svg", height: Utils(context).getMediaHeight() * 0.03,),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "${partnerData != null ? partnerData.name ?? "" : ""}",
                        style: TextStyle(
                          fontSize: Utils(context).getMediaWidth() * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ],
                ),
              ) : Container(),
              Container(
                  height: Utils(context).getMediaHeight(),
                  child: Center(
                    child: ideasListResponse != null
                        ? ideasListResponse.data.length > 0
                            ? GridView.builder(
                                itemCount: ideasListResponse != null
                                    ? ideasListResponse.data.length
                                    : 0,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemBuilder: (BuildContext context, index) {
                                  return  IdeasCardContainer(
                                      ideasData: ideasListResponse.data[index]);// Container();
                                  /*Container(
                      height: Utils(context).getMediaHeight() * 0.6,
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0XFFE8F6F1),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[200],
                            spreadRadius: 2,
                            // blurRadius: 1
                          ),
                        ],
                      ),
                      child: GridTile(
                        header: Container(
                          padding: EdgeInsets.only(top: 10.0, bottom: 8.0),
                          child: Image.asset(
                            "assets/ideaImg2.png",
                            // fit: BoxFit.cover,
                            height: Utils(context).getMediaHeight() * 0.14,
                            width: 1,
                          ),
                        ),
                        child: SizedBox(),
                        footer: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Out Date Night",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: Utils(context).getMediaWidth() * 0.05,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    );*/
                                })
                            : NoRecordFoundScreen(
                                msg: "No Record Found",
                              )
                        : NoRecordFoundScreen(
                            icon: FontAwesomeIcons.fileDownload,
                            msg: "Please Wait",
                          ),
                  ),
                ),
            ],
          ),
        )
        : Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              leading: CustomMenuButton(
                handler: () {
                  _scaffoldKey.currentState.openDrawer();
                },
              ),
              backgroundColor: APP_BAR_COLOR,
              title: partnerData != null ? Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0XFF6341DF), Color(0XFF1E8FED)]),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "${userDetails != null ? userDetails.name ?? "" : ""}",
                        style: TextStyle(
                            fontSize: Utils(context).getMediaWidth() * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                    ),
                    SvgPicture.asset("assets/hearts.svg", height: Utils(context).getMediaHeight() * 0.03,),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "${partnerData != null ? partnerData.name ?? "" : ""}",
                        style: TextStyle(
                            fontSize: Utils(context).getMediaWidth() * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ],
                ),
              ) : Container(child: Text(
                "${suggesiontypeListsResponse!=null?suggesiontypeListsResponse.data.where((element) => element.id==1).first.name:'Date Ideas'}",
                style: TextStyle(color: Colors.black),
              ),),/* Text(
                "${suggesiontypeListsResponse!=null?suggesiontypeListsResponse.data.where((element) => element.id==1).first.name:'Date Ideas'}",
                style: TextStyle(color: Colors.black),
              ),*/
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationsListScreen()));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: AppBarActionButton(
                      buttonIcon: Icon(
                        FontAwesomeIcons.bell,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: Container(
              child: Center(
                child: ideasListResponse != null
                    ? ideasListResponse.data.length > 0
                        ? GridView.builder(
                            itemCount: ideasListResponse != null
                                ? ideasListResponse.data.length
                                : 0,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (BuildContext context, index) {
                              return IdeasCardContainer(
                                  ideasData: ideasListResponse.data[index]) ;// Container();
                            })
                        : HartScreenComponent()
                    : NoRecordFoundScreen(
                        icon: FontAwesomeIcons.fileDownload,
                        msg: "Please Wait",
                      ),
              ),
            ),
            drawer: CustomMenuDrawer(userDetails),
          );
  }
}
