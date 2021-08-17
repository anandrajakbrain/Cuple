import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:flutter/material.dart';

class FunnyCardListScreen extends StatefulWidget {
  final String partnerName;

  FunnyCardListScreen({@required this.partnerName});

  @override
  _FunnyCardListScreenState createState() => _FunnyCardListScreenState();
}

class _FunnyCardListScreenState extends State<FunnyCardListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        backgroundColor: APP_BAR_COLOR,
        title: Text(
          "Funny Cards for ${widget.partnerName}",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: APP_BAR_COLOR,
        ),
        child: Center(
          child: GridView.builder(
            itemCount: 10,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/funnyCardImg1.png"),
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        blurRadius: 2,spreadRadius: 1,
                      ),
                    ],
                  ),
                );

              }),
        ),
      ),
    );
  }
}
