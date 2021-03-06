import 'dart:convert';

import 'package:cuple_app/componets/inputFeildUI.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/beforeRegisterResponse.dart';
import 'package:cuple_app/model/facebookUserData.dart';
import 'package:cuple_app/model/getOTPResponse.dart';
import 'package:cuple_app/model/registerUserResponse.dart';
import 'package:cuple_app/model/states_response.dart';
import 'package:cuple_app/model/verifyOTPResponse.dart';
import 'package:cuple_app/screens/beforeReagisterOtpScreen.dart';
import 'package:cuple_app/screens/otpVerficationScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart' as fb;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'login.dart';
import 'dart:convert' show json;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:auth/auth.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final fbLogin = FacebookLogin();
  final FirebaseAuth auth = FirebaseAuth.instance;
  StatesResponse statesResponse;
  StatesData statesData;
  TextEditingController nameController,
      emailController,
      firstNameController,
      lastNameController,
      stateController,
      phoneController = new TextEditingController();
  String gender = "Male";
  var _formKey = GlobalKey<FormState>();
  var user;
  String name, email, phone, firstname, lastName, stateName;
  bool isLoggedIn = false;
  GoogleSignInAccount _currentUser;
  String _contactText = '';
PreviewReg previewReg;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0)).then((value) {
      getStatesList();
    });
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact(_currentUser);
      }
    });
    _googleSignIn.signInSilently();
  }

  getStatesList() async{
    StatesResponse _stateResponse = await Plugs(context).getStatesList();
    setState(() {
      statesResponse = _stateResponse;
    });
  }


  loginWithSocialMediaData(
      {String socailType,
      String name,
      String email,
      String phone,
      String photoUrl}) async {
    VerifyOTPResponse verifyOTPResponse = await Plugs(context)
        .loginWithSocialMedia(socailType, name, email, phone, photoUrl);
    if (verifyOTPResponse.success == true) {
      SharedPreferences prf = await SharedPreferences.getInstance();
      prf.setString("user", jsonEncode(verifyOTPResponse.user));
      prf.setString("token", verifyOTPResponse.accessToken);

      print(verifyOTPResponse.toJson());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      Utils(context).showMessage(
        title: "Error",
        child: Text(verifyOTPResponse.message),
      );
    }
  }

  login(GoogleSignInAccount user) async {
    VerifyOTPResponse verifyOTPResponse = await Plugs(context)
        .loginWithSocialMedia("Google", user.displayName, user.email,
            "0000000000", user.photoUrl);
    if (verifyOTPResponse.success == true) {
      SharedPreferences prf = await SharedPreferences.getInstance();
      prf.setString("user", jsonEncode(verifyOTPResponse.user));
      prf.setString("token", verifyOTPResponse.accessToken);

      print(verifyOTPResponse.toJson());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      Utils(context).showMessage(
        title: "Error",
        child: Text(verifyOTPResponse.message),
      );
    }
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = "Loading contact info...";
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = "People API gave a ${response.statusCode} "
            "response. Check logs for details.";
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    final String namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = "I see you know $namedContact!";
      } else {
        _contactText = "No contacts to display.";
      }
    });
  }

  String _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic> connections = data['connections'];
    final Map<String, dynamic> contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );
    if (contact != null) {
      final Map<String, dynamic> name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn().then((value) {
        print(value.photoUrl +
            "************************************************");
        login(value);
        setState(() {
          _currentUser = value;
          _handleGetContact(value);
        });
      });
    } catch (error) {
      print(
          error.toString() + "***********************************************");
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      print(value.user.displayName);
    });
  }

  //------------------------------------------------------------------------------------------------------

  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }

  /*static final fb.FacebookLogin facebookSignIn = new fb.FacebookLogin();

  String _message = 'Log in/out by pressing the buttons below.';

  Future<Null> _login() async {
    final fb.FacebookLoginResult result =
    await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case fb.FacebookLoginStatus.loggedIn:
        final fb.FacebookAccessToken accessToken = result.accessToken;
        _showMessage('''
         Logged in!

         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        break;
      case fb.FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
        break;
      case fb.FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  Future<Null> _logOut() async {
    await facebookSignIn.logOut();
    _showMessage('Logged out.');
  }

  void _showMessage(String message) {
    setState(() {
      _message = message;
      print(message);
    });
  }*/

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
                    controller: firstNameController,
                    labelName: "First Name",
                    getvalue: (value) {
                      setState(() {
                        firstname = value;
                      });
                    },
                  ),
                  RegisterInputField(
                    controller: lastNameController,
                    labelName: "Last Name",
                    getvalue: (value) {
                      setState(() {
                        lastName = value;
                      });
                    },
                  ),
                  RegisterInputField(
                    controller: emailController,
                    labelName: "Email",
                    TxtInputType: TextInputType.emailAddress,
                    formType: "email",
                    getvalue: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  RegisterInputField(
                    controller: phoneController,
                    labelName: "Mobile Number",
                    TxtInputType: TextInputType.phone,
                    formType: "phone",
                    getvalue: (value) {
                      setState(() {
                        phone = value;
                      });
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      value: statesData,
                      items: statesResponse != null ?  statesResponse.data
                          .map(
                            (e) => DropdownMenuItem(
                          child: Text(e.state_name),
                          value: e,
                        ),
                      )
                          .toList() : ['--']
                          .map((label) => DropdownMenuItem(
                        child: Text(label.toString()),
                        value: label,
                      ))
                          .toList(),
                      decoration: InputDecoration(
                        labelText: "State",
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
                      onChanged: (value) {
                        setState(() {
                          statesData = value;
                          stateName = statesData.state_name;
                        });
                        //getReminderName(reminderTypeVal.id);
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Please Select State";
                        }
                        return null;
                      },
                    ),
                  ),
                  /*Container(
                    padding: EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      value: gender,
                      items: ["Male", "Female"]
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      decoration: InputDecoration(
                        labelText: "Gender",
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
                      onChanged: (text) {
                        setState(() {
                          gender = text;
                        });
                      },
                    ),
                  ),*/
                  SizedBox(
                    height: Utils(context).getMediaHeight() * 0.06,
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        // register();
                        beforeRagisterOtp();
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
                            _handleSignIn();
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
                            // facebookLogin(context);

                            _Facebooklogin();
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
                                    new MaterialPageRoute(
                                        builder: (context) =>
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

/*
* TODO : If Register with google cause error
* https://stackoverflow.com/questions/56188338/platformexception-platformexceptionsign-in-failed-com-google-android-gms-comm
* check this
* */

  beforeRagisterOtp() async{
    BeforeRegisterResponse beforeRegisterResponse=await Plugs(context).beforeRegister(email: email, phone: phone, name: "$firstname $lastName",first_name: firstname,last_name: lastName,state: stateName,gender: "Male");
    if(beforeRegisterResponse.success==true){
      previewReg =PreviewReg(firstName: firstname,lastName: lastName,name: "$firstname $lastName",phone: phone,gender: "Male",state: stateName,otp: beforeRegisterResponse.data.otp.toString(),email: email);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => BeforeReagisterOtpScreen(previewReg: previewReg,),
        ),
            (route) => false,
      );
    }else{
      Utils(context).showMessage(
        title: "Error",
        child: Text(beforeRegisterResponse.message),
      );
    }
  }


  register() async {
    RegisterUserResponse registerUserResponse = await Plugs(context).register(
        email: email,
        phone: phone,
        name: "$firstname $lastName",
        gender: gender,
        first_name: firstname,
        last_name: lastName,
        state: stateName,

    );
    if (registerUserResponse.success == true) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
        (route) => false,
      );
      // GetOTPResponse getOTPResponse =
      //     await Plugs(context).requestForOTP(name: email);
      // if (getOTPResponse.success == true) {
      //   print(getOTPResponse.data.otp);

      /*  Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => OtpVerificationScreen(getOTPResponse: getOTPResponse,name: name,),

            ),(route) => false,);*/

      // } else {
      //   Utils(context).showMessage(
      //     title: "Error",
      //     child: Text(getOTPResponse.message),
      //   );
      // }
    } else {
      Utils(context).showMessage(
        title: "Error",
        child: Text(registerUserResponse.message),
      );
    }
  }

  Future<void> _Facebooklogin() async {
    try {
      // by default the login method has the next permissions ['email','public_profile']
      AccessToken accessToken = await FacebookAuth.instance.login();

      print(accessToken.toJson());
      // get the user data
      final userData = await FacebookAuth.instance.getUserData();
      print("user Data ");
      print(userData);
      FacebookUserDataResponse facebookUserDataResponse =
          FacebookUserDataResponse.fromJson(userData);
      loginWithSocialMediaData(
        socailType: "facebook",
        name: facebookUserDataResponse.name,
        email: facebookUserDataResponse.email,
        phone: "00000000",
        photoUrl: facebookUserDataResponse.picture != null
            ? facebookUserDataResponse.picture.data.url
            : '',
      );
    } on FacebookAuthException catch (e) {
      switch (e.errorCode) {
        case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
          print("You have a previous login operation in progress");
          break;
        case FacebookAuthErrorCode.CANCELLED:
          print("login cancelled");
          break;
        case FacebookAuthErrorCode.FAILED:
          print("Facebook Login ");
          print(e.message);
          print("login failed");
          break;
      }
    }
  }
}

class PreviewReg {
  String name;
  String firstName;
  String lastName;
  String phone;
  String gender;
  String state;
  String otp;
  String email;

  PreviewReg({
    this.name,
    this.firstName,
    this.lastName,
    this.phone,
    this.gender,
    this.state,
    this.otp,
    this.email,
  });
}
