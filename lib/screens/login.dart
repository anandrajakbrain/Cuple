import 'package:cuple_app/componets/inputFeildUI.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/getOTPResponse.dart';
import 'package:cuple_app/screens/otpVerficationScreen.dart';
import 'package:cuple_app/screens/registerScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController,
      emailController,
      phoneController = new TextEditingController();
  String name;
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: APP_PRIMARY_COLOR,
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Utils(context).getMediaHeight() * 0.06,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: TextStyle(
                        color: Color.fromRGBO(40, 40, 40, 1),
                        fontSize: Utils(context).getMediaWidth() * 0.06,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(text: "Enter Your Mobile Number"),
                        TextSpan(
                          text: "\nor",
                          style: TextStyle(
                            color: Color.fromRGBO(104, 104, 104, 1),
                            fontSize: Utils(context).getMediaWidth() * 0.06,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(text: "\nEmail for Login"),
                      ]),
                ),
                SizedBox(
                  height: Utils(context).getMediaHeight() * 0.01,
                ),
                Text(
                  "You will get a OTP via SMS or Email",
                  style: TextStyle(
                    color: Color.fromRGBO(104, 104, 104, 1),
                    fontSize: Utils(context).getMediaWidth() * 0.04,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: Utils(context).getMediaHeight() * 0.06,
                ),
                RegisterInputField(
                  controller: nameController,
                  labelName: "Mobile No./Email",
                  formkey: _formKey,
                  getvalue: (value){
                    setState(() {
                      name=value;
                    });

                  },
                ),
                SizedBox(
                  height: Utils(context).getMediaHeight() * 0.06,
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      getlogin();
                      //
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
                          'GENERATE OTP',
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
                  height: Utils(context).getMediaHeight() * 0.026,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: Utils(context).getMediaHeight() * 0.05,
                    bottom: Utils(context).getMediaHeight() * 0.05,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't Have An Account? ",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                          // recognizer: TapGestureRecognizer()..onTap = () {
                          // Single tapped.
                          // },
                        ),
                        TextSpan(
                          text: 'SIGN UP',
                          style: TextStyle(
                              color: Color(0XFFB216BB),
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("Sign up");
                              Navigator.of(context).pushReplacement(
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          new RegisterScreen()));
                              // Single tapped.
                            },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getlogin() async {
    print("name controller");
print(name);
    GetOTPResponse getOTPResponse =
        await Plugs(context).requestForOTP(name: name);
if(getOTPResponse.success==true){
  print(getOTPResponse.data.otp);
  print(name);
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => OtpVerificationScreen(getOTPResponse: getOTPResponse,name: name,)));
}else{

  Utils(context).showMessage(title: "Error",child: Text(getOTPResponse.message),);

}

  }
}
