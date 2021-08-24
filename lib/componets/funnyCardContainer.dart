import 'package:cuple_app/configuration/APIs.dart';
import 'package:cuple_app/model/funnycardsListsResponse.dart';
import 'package:flutter/material.dart';

class FunnyCardContainer extends StatefulWidget {
FunnyCardData funnyCardData;
FunnyCardContainer({@required this.funnyCardData});
 @override
  _FunnyCardContainerState createState() => _FunnyCardContainerState();
}

class _FunnyCardContainerState extends State<FunnyCardContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(APP_ASSET_BASE_URL + widget.funnyCardData.image,),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300],
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
}
