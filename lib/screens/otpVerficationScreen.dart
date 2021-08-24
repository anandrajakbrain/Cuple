import 'dart:convert';

import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/getOTPResponse.dart';
import 'package:cuple_app/model/verifyOTPResponse.dart';
import 'package:cuple_app/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpVerificationScreen extends StatefulWidget {
  GetOTPResponse getOTPResponse;
  String name;

  OtpVerificationScreen({@required this.name, @required this.getOTPResponse});

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final BoxDecoration pinPutDecoration = BoxDecoration(
      color: Colors.white, //const Color.fromRGBO(25, 21, 99, 1),
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: Colors.black)
      // border: Border.all(color: Colors.black26),
      );
  final FocusNode _pinPutFocusNode = FocusNode();
  final TextEditingController _pinPutController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Vector.png"),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: Utils(context).getMediaHeight() * 0.12,
                width: Utils(context).getMediaWidth() * 0.11,
                child: Image.asset(
                  "assets/phoneIcon.png",
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.03,
              ),
              Text(
                "Enter Generated OTP",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Utils(context).getMediaWidth() * 0.04),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.01,
              ),
              Text(
                "OTP has been sent to your Mobile Number\n or Email Address",
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.06,
              ),
              Container(
                width: Utils(context).getMediaWidth() * 0.80,
                child: PinPut(
                  keyboardType: TextInputType.number,
                  // eachFieldWidth: 10.0,
                  eachFieldHeight: 10.0,
                  fieldsCount: 6,
                  autofocus: false,
                  focusNode: _pinPutFocusNode,
                  controller: _pinPutController,
                  onSubmit: (String pin) {
                    //Toast.show(pin, context);
                  },
                  onChanged: (text) {
                    // Toast.show(text, context);
                  },
                  validator: (value) {
                    // if (!showError) {
                    //   return null;
                    // }
                    if (value.isEmpty) {
                      return "This field is required";
                    }
                    if (value.length < 6) {
                      return "Invalid verification code";
                    }
                    // if (errorMessage != null) {
                    //   return errorMessage;
                    // }
                    return null;
                  },
                  submittedFieldDecoration: pinPutDecoration,
                  selectedFieldDecoration: pinPutDecoration,
                  followingFieldDecoration: pinPutDecoration,
                  pinAnimationType: PinAnimationType.scale,
                  textStyle: TextStyle(
                      // color: darkInputBorderLine,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: Utils(context).getMediaHeight() * 0.06,
              ),
              InkWell(
                onTap: () {
                  // if (_formKey.currentState.validate()) {
                  //
                  // }
                  verifyotp();
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
                        'SUBMIT',
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
        ),
      ),
    );
  }

  verifyotp() async {
    print(widget.name);
    print(_pinPutController.text);
    VerifyOTPResponse verifyOTPResponse = await Plugs(context)
        .verifyOTP(name: widget.name, Otp: _pinPutController.text);
    if (verifyOTPResponse.success == true) {
      SharedPreferences prf=await SharedPreferences.getInstance();
      prf.setString("user", jsonEncode(verifyOTPResponse.user));
      prf.setString("token", verifyOTPResponse.accessToken);

      print(verifyOTPResponse.toJson());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }else{
      Utils(context).showMessage(title: "Error",child: Text(verifyOTPResponse.message),);
    }


  }
}
