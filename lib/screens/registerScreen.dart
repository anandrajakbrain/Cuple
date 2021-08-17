import 'package:cuple_app/componets/inputFeildUI.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/screens/otpVerficationScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'login.dart';
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController,
      emailController,phoneController = new TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APP_PRIMARY_COLOR,
      body: SingleChildScrollView(
        child: Container(
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
                  Text(
                    "Create An Account",
                    style: TextStyle(
                      fontSize: Utils(context).getMediaWidth() * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: Utils(context).getMediaHeight() * 0.06,
                  ),
                  RegisterInputField(
                      controller: nameController, labelName: "Name"),
                  RegisterInputField(
                      controller: emailController, labelName: "Email",TxtInputType: TextInputType.emailAddress,formType: "email",),
                  RegisterInputField(
                    controller: phoneController,
                    labelName: "Mobile Number",
                    TxtInputType: TextInputType.phone,
                    formType: "phone",
                  ),
                  SizedBox(
                    height: Utils(context).getMediaHeight() * 0.06,
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerificationScreen()));
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
                  SizedBox(
                    height: Utils(context).getMediaHeight() * 0.026,
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: new Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 15.0),
                          child: Divider(
                            color: Colors.grey,
                            height: 50,
                          )),
                    ),
                    Text(
                      "OR",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      child: new Container(
                          margin:
                              const EdgeInsets.only(left: 15.0, right: 10.0),
                          child: Divider(
                            color: Colors.grey,
                            height: 50,
                          )),
                    ),
                  ]),
                  SizedBox(
                    height: Utils(context).getMediaHeight() * 0.026,
                  ),
                  Container(
                    margin: EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            print("Tap Work");
                          },
                          child: Container(
                            child: Image.asset(
                              "assets/google.png",
                              fit: BoxFit.contain,
                            ),
                            decoration: BoxDecoration(),
                            height: Utils(context).getMediaWidth() * 0.08,
                          ),
                        ),
                        SizedBox(
                          width: Utils(context).getMediaWidth() * 0.08,
                        ),
                        InkWell(
                          onTap: () {
                            print("Tap Work");
                          },
                          child: Container(
                            child: Image.asset(
                              "assets/facebook.png",
                              fit: BoxFit.contain,
                            ),
                            decoration: BoxDecoration(),
                            height: Utils(context).getMediaWidth() * 0.08,
                          ),
                        ),
                      ],
                    ),
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
                            text: 'Already Have An Account? ',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                            // recognizer: TapGestureRecognizer()..onTap = () {
                            // Single tapped.
                            // },
                          ),
                          TextSpan(
                            text: 'SIGN IN',
                            style: TextStyle(
                                color: Color(0XFFB216BB),
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print("Sign In");
                                Navigator.of(context).pushReplacement(
                                    new MaterialPageRoute(builder: (context) =>
                                    new LoginScreen()));
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
      ),
    );
  }
}
