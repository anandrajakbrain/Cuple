import 'dart:convert';

import 'package:cuple_app/configuration/APIs.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/createNewReminderResponse.dart';
import 'package:cuple_app/model/funnycardsListsResponse.dart';
import 'package:cuple_app/model/getOTPResponse.dart';
import 'package:cuple_app/model/ideasListResponse.dart';
import 'package:cuple_app/model/listUserReminderResponse.dart';
import 'package:cuple_app/model/loginResponse.dart';
import 'package:cuple_app/model/notificationsListsResponse.dart';
import 'package:cuple_app/model/remindersListsResponse.dart';
import 'package:cuple_app/model/tipsListResponse.dart';
import 'package:cuple_app/model/verifyOTPResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
User userDetails;
String token;
class Plugs {
  BuildContext context;

  Plugs(@required this.context);

  Future<LoginResponse> login(
      {@required String email, @required String password}) async {
    Utils(context).showProgressLoader();
    var body = {
      "email": email,
      "password": password,
    };
    try {
      http.Response response =
          await http.post(LOGIN, headers: getHeaders(), body: body);
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return LoginResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(response.body);
      }
    } catch (e, s) {
      Navigator.pop(context);
      Utils(context).showMessage(
        title: "Error",
        child: Text("$e"),
      );
      throw Exception(e);
    }
  }

  Future<GetOTPResponse> requestForOTP({@required String name}) async {
    Utils(context).showProgressLoader();
    var body = {
      "name": name,
      // "password": password,
    };
    try {
      http.Response response =
          await http.post(GET_OTP, headers: getHeaders(), body: body);
      if (response.statusCode == 200) {
        // print(jsonDecode(response.body)['success']);
        Navigator.pop(context);
        GetOTPResponse _getOTP =
            GetOTPResponse.fromJson(jsonDecode(response.body));
        print(_getOTP);
        return GetOTPResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(jsonDecode(response.body));
      }
    } catch (e, s) {
      Navigator.pop(context);
      print("===========================>Error========================>");
      print(e);
      print(s);
      Utils(context).showMessage(
        title: "Error",
        // temp=jsonDecode(source);
        child: Text("${e}"),
      );
      // throw Exception(e);
    }
  }

  Future<VerifyOTPResponse> verifyOTP(
      {@required String name, String Otp}) async {
    Utils(context).showProgressLoader();
    var body = {
      "name": name,
      "otp": Otp,
      // "password": password,
    };
    try {
      http.Response response =
          await http.post(VERIFY_OTP, headers: getHeaders(), body: body);
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return VerifyOTPResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(response.body);
      }
    } catch (e, s) {
      Navigator.pop(context);
      print("===========================>Error========================>");
      print(e);
      print(s);
      Utils(context).showMessage(
        title: "Error",
        child: Text("$e"),
      );
      // throw Exception(e);
    }
  }

  Future<NotificationsListsResponse> getNotificationList(
      {@required String name }) async {
    Utils(context).showProgressLoader();
    var body = {
      "name": name,

      // "password": password,
    };
    try {
      http.Response response =
          await http.get(NOTIFICATION_LIST, headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return NotificationsListsResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(response.body);
      }
    } catch (e, s) {
      Navigator.pop(context);
      print("===========================>Error========================>");
      print(e);
      print(s);
      Utils(context).showMessage(
        title: "Error",
        child: Text("$e"),
      );
      // throw Exception(e);
    }
  }
  Future<ListUserReminderResponse> listUserReminderList(
      {@required String userId }) async {
    Utils(context).showProgressLoader();

    try {
      http.Response response =
          await http.get(LIST_USER_REMINDER+"?user_id=$userId", headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return ListUserReminderResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(response.body);
      }
    } catch (e, s) {
      Navigator.pop(context);
      print("===========================>Error========================>");
      print(e);
      print(s);
      Utils(context).showMessage(
        title: "Error",
        child: Text("$e"),
      );
      // throw Exception(e);
    }
  }
  Future<RemindersListsResponse> getreminderTypeList(
      {@required String type }) async {
    Utils(context).showProgressLoader();

    try {
      http.Response response =
          await http.get(REMINDERS_LIST+"?type=$type", headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return RemindersListsResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(response.body);
      }
    } catch (e, s) {
      Navigator.pop(context);
      print("===========================>Error========================>");
      print(e);
      print(s);
      Utils(context).showMessage(
        title: "Error",
        child: Text("$e"),
      );
      // throw Exception(e);
    }
  }
  Future<CreateNewReminderResponse> createNewReminder({@required String category,RemindersListData remindersListData,String date}) async {
    Utils(context).showProgressLoader();
    var body = {
      "user_id": userDetails.id.toString(),
      "reminder_id":remindersListData.id.toString(),
      "date":date,
      "status":"Active"
      // "password": password,
    };
    try {
      http.Response response =
      await http.post(CREATE_USER_REMINDER, headers: getHeaders(), body: body);
      if (response.statusCode == 200) {
        // print(jsonDecode(response.body)['success']);
        Navigator.pop(context);

        return CreateNewReminderResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(jsonDecode(response.body));
      }
    } catch (e, s) {
      Navigator.pop(context);
      print("===========================>Error========================>");
      print(e);
      print(s);

      // throw Exception(e)Utils(context).showMessage(
      //         title: "Error",
      //         // temp=jsonDecode(source);
      //         child: Text("${e}"),
      //       );;
    }
  }
  Future<FunnycardsListsResponse> getFunnyCards(
      {@required String type }) async {
    Utils(context).showProgressLoader();

    try {
      http.Response response =
      await http.get(FUNNY_CARD_LIST, headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return FunnycardsListsResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(response.body);
      }
    } catch (e, s) {
      Navigator.pop(context);
      print("===========================>Error========================>");
      print(e);
      print(s);
      Utils(context).showMessage(
        title: "Error",
        child: Text("$e"),
      );
      // throw Exception(e);
    }
  }

  Future<TipsListResponse> getTipsList(
      {@required String type ="tips"}) async {
    Utils(context).showProgressLoader();

    try {
      http.Response response =
      await http.get(SUGGESION_TYPE_LIST+"?type=$type", headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return TipsListResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(response.body);
      }
    } catch (e, s) {
      Navigator.pop(context);
      print("===========================>Error========================>");
      print(e);
      print(s);
      Utils(context).showMessage(
        title: "Error",
        child: Text("$e"),
      );
      // throw Exception(e);
    }
  }
  Future<IdeasListResponse> getIdeasList(
      {@required String type ="ideas"}) async {
    Utils(context).showProgressLoader();

    try {
      http.Response response =
      await http.get(SUGGESION_TYPE_LIST+"?type=$type", headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return IdeasListResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(response.body);
      }
    } catch (e, s) {
      Navigator.pop(context);
      print("===========================>Error========================>");
      print(e);
      print(s);
      Utils(context).showMessage(
        title: "Error",
        child: Text("$e"),
      );
      // throw Exception(e);
    }
  }

  Map<String, String> getHeaders({String token = null}) {
    return <String, String>{
      // 'content-type': 'application/json',
      "Content-Type": "application/x-www-form-urlencoded",
      // "content-type": "application/x-www-form-urlencoded",
      'accept': 'application/json; charset=UTF-8',
      if (token != null) "authorization": "Bearer " + token
    };
  }
}
