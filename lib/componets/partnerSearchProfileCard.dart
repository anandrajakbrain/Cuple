import 'package:cuple_app/componets/friendRequestCard.dart';
import 'package:cuple_app/configuration/APIs.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/findPartnerResponse.dart';
import 'package:cuple_app/model/sendPartnerRequestResponse.dart';
import 'package:flutter/material.dart';

class PartnerProfileCard extends StatefulWidget {
  FindPartnerData findPartnerData;
  final callback;

  PartnerProfileCard({@required this.findPartnerData, @required this.callback});

  @override
  _PartnerProfileCardState createState() => _PartnerProfileCardState();
}

class _PartnerProfileCardState extends State<PartnerProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              spreadRadius: 1,
              blurRadius: 1,
            ),
          ]),
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              widget.callback();
            },
            child: Align(
              child: Container(
                child: Icon(Icons.close_rounded),
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    50.0,
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[300],
                        blurRadius: 1,
                        spreadRadius: 1),
                  ],
                ),
              ),
              alignment: Alignment.topRight,
            ),
          ),
          Row(
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
                    image: widget.findPartnerData.picture != "0"
                        ? NetworkImage(
                            widget.findPartnerData.uploaded != null
                                ? APP_ASSET_BASE_URL +
                                    widget.findPartnerData.picture
                                : widget.findPartnerData.picture,
                          )
                        : AssetImage("assets/profile_user.jpg"),
                  ),
                ),

                // child: Image.asset("assets/profile_user.jpg",fit: BoxFit.contain),
              ),
              Expanded(
                child: Text(
                  "${widget.findPartnerData.name ?? ''}",
                  style: TextStyle(
                      fontSize: Utils(context).getMediaWidth() * 0.05),
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              sendRequest();

              // if (_formKey.currentState.validate()) {
              //   // register();
              //   // Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerificationScreen()));
              // }
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
                    'SEND REQUEST',
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
    );
  }

  sendRequest() async {
    SendPartnerRequestResponse sendPartnerRequestResponse = await Plugs(context)
        .sendPartnerRequest(
            userId: userDetails.id.toString(),
            friendId: widget.findPartnerData.id.toString());
    Utils(context).showMessage(
        title: "", child: Text(sendPartnerRequestResponse.message));

    widget.callback();
  Navigator.pop(context);
  }
}
