

import 'package:cuple_app/componets/partnerSearchProfileCard.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/findPartnerResponse.dart';
import 'package:cuple_app/model/sendInvitationResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPartnerScreen extends StatefulWidget {
  @override
  _SearchPartnerScreenState createState() => _SearchPartnerScreenState();
}

class _SearchPartnerScreenState extends State<SearchPartnerScreen> {
  var _formKey = GlobalKey<FormState>();
  String searchPartner;
  FindPartnerResponse findPartnerResponse;

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
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.06,
              ),
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
                    getPartner();
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
                    itemCount: findPartnerResponse != null
                        ? findPartnerResponse.alldata.data.length
                        : 0,
                    itemBuilder: (context, index) {
                      return PartnerProfileCard(
                        findPartnerData:
                            findPartnerResponse.alldata.data[index],
                        callback: () {
                          setState(() {
                            findPartnerResponse.alldata.data.removeAt(index);
                          });
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getPartner() async {
    if(findPartnerResponse!=null){
      setState(() {
        findPartnerResponse=null;
      });
    }
    FindPartnerResponse _findPartnerResponse =
        await Plugs(context).findPartner(search_key: searchPartner);
    print("Work");
    if (_findPartnerResponse.alldata.data.length < 1) {
      print("Not Exist");
      Utils(context).showAlert(
          context: context,
          title: "Sorry",
          child: Text(
              "We Did'nt Find $searchPartner would you want to send invitation ?"),
          handler: () async{
          SendInvitationResponse sendInvitationResponse= await  Plugs(context).sendInvitation(email: searchPartner);
         if(sendInvitationResponse.success==true){
           Navigator.pop(context);
           Utils(context).showMessage(title: "Success",child: Text("We SuccessFully Send Invite "));
         }

          },
          isCancel: true);
    } else {
      print("exist");
      setState(() {
        findPartnerResponse = _findPartnerResponse;
      });
    }
  }
}
