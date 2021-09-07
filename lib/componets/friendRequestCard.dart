import 'package:cuple_app/configuration/utils.dart';
import 'package:flutter/material.dart';

class FriendRequestCard extends StatefulWidget {
  @override
  _FriendRequestCardState createState() => _FriendRequestCardState();
}

class _FriendRequestCardState extends State<FriendRequestCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Utils(context).getMediaHeight()*0.40,
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
                image: AssetImage("assets/profile_user.jpg"),
              ),
            ),

            // child: Image.asset("assets/profile_user.jpg",fit: BoxFit.contain),
          ),
          Text("Jessica Chaestain",style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(height: 10,),
          InkWell(
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
          SizedBox(height: 10,),
          InkWell(
            child: SizedBox(
              width: Utils(context).getMediaWidth() * 0.80,
              child: Container(
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(color: Color(0XFF1E8FED))
                ),
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
    );
  }
}
