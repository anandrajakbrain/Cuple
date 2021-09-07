import 'package:cuple_app/componets/partnerSearchProfileCard.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPartnerScreen extends StatefulWidget {
  @override
  _SearchPartnerScreenState createState() => _SearchPartnerScreenState();
}

class _SearchPartnerScreenState extends State<SearchPartnerScreen> {
  var _formKey = GlobalKey<FormState>();
  String searchPartner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: APP_BAR_COLOR,
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: Utils(context).getMediaHeight()*0.06,),
              Text(
                "Find Your Partner",
                style: TextStyle(
                  fontSize: Utils(context).getMediaWidth() * 0.07,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    // controller: widget.controller,
                    decoration: InputDecoration(
                      labelText: "Email/Mobile Number",
                      labelStyle: TextStyle(
                        fontSize: Utils(context).getMediaWidth() * 0.059,
                        color: Colors.grey[500],
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.grey[300],
                          // width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "! Please Enter Email Or Mobile ";
                      }

                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        searchPartner = val;
                      });
                    },
                    /*onChanged: (val){
          if (_formkey.currentState.validate()) {
            print("Validated");
          }else{
            print("Not Validated");
          }
        },*/
                  ),
                ),
              ),
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.03,
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    // register();
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerificationScreen()));
                  }
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
                        'SEARCH',
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
              Container(
                height: Utils(context).getMediaHeight() * 0.60,
                child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return PartnerProfileCard();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
