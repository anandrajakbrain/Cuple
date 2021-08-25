import 'dart:convert';

import 'package:cuple_app/configuration/APIs.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/createNewReminderResponse.dart';
import 'package:cuple_app/model/deleteWishListResponse.dart';
import 'package:cuple_app/model/funnycardsListsResponse.dart';
import 'package:cuple_app/model/getMsgResponse.dart';
import 'package:cuple_app/model/getOTPResponse.dart';
import 'package:cuple_app/model/ideasListResponse.dart';
import 'package:cuple_app/model/listUserReminderResponse.dart';
import 'package:cuple_app/model/loginResponse.dart';
import 'package:cuple_app/model/notificationsListsResponse.dart';
import 'package:cuple_app/model/registerUserResponse.dart';
import 'package:cuple_app/model/remindersListsResponse.dart';
import 'package:cuple_app/model/sendMsgResponse.dart';
import 'package:cuple_app/model/tipsListResponse.dart';
import 'package:cuple_app/model/userWishListResponse.dart';
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
  Future<RegisterUserResponse> register(
      {@required String email, @required String phone,@required String name}) async {
    Utils(context).showProgressLoader();
    var body = {
      "email": email,
      "phone": phone,
      "name":name,
      "image":"",
      // "password":"0",
    };
    try {
      http.Response response =
          await http.post(REGISTERUSER, headers: getHeaders(), body: body);
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return RegisterUserResponse.fromJson(jsonDecode(response.body));
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

  Future<LoginResponse> updateSettings(var userId, var chat, var notification, var frequency,
    var questionnaire, var dateNights, var msgFrequency) async {
    Utils(context).showProgressLoader();
    var body = {
      "user_id": userId,
      "chat": chat,
      "notification" : notification,
      "frequency" : frequency,
      "questionnaire" : questionnaire,
      "date_nights" : dateNights,
      "msg_frequency" : msgFrequency,
    };
    try {
      http.Response response =
      await http.post(USER_SETTINGS, headers: getHeaders(), body: body);
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

  Future<User> updateUserDetails(var userId, var name, var email, var phone, var dob) async {
    Utils(context).showProgressLoader();
    var body = {
      "id": userId,
      "name": name,
      "email" : email,
      "phone" : phone,
      "dob" : dob,
    };
    try {
      http.Response response =
      await http.post(UPDATE_USER, headers: getHeaders(), body: body);
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return User.fromJson(jsonDecode(response.body)["data"]);
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

  Future<NotificationsListsResponse> getNotificationList(var id, {@required String name }) async {
    Utils(context).showProgressLoader();
    var body = {
      "name": name,

      // "password": password,
    };
    try {
      http.Response response =
          await http.get(NOTIFICATION_LIST+"?user_id=$id", headers: getHeaders(token: token));
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


  Future<NotificationsListsResponse> deleteNotification(var id, {@required String name }) async {
    Utils(context).showProgressLoader();
    var body = {
      "name": name,

      // "password": password,
    };
    try {
      http.Response response =
      await http.delete(DELETE_USER_NOTIFICATION+"?id=$id", headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return jsonDecode(response.body);
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

  Future<NotificationsListsResponse> deleteAllNotifications(var delIds, {@required String name }) async {
    Utils(context).showProgressLoader();
    var body = {
      "name": name,

      // "password": password,
    };
    try {
      http.Response response =
      await http.delete(DELETE_ALL_USER_NOTIFICATION+"?$delIds", headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return jsonDecode(response.body);
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
      {@required String userId}) async {
    Utils(context).showProgressLoader();

    try {
      http.Response response = await http.get(
          LIST_USER_REMINDER + "?user_id=$userId",
          headers: getHeaders(token: token));
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
      {@required String type}) async {
    Utils(context).showProgressLoader();

    try {
      http.Response response = await http.get(REMINDERS_LIST + "?type=$type",
          headers: getHeaders(token: token));
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

  Future<CreateNewReminderResponse> createNewReminder(
      {@required String category,
      RemindersListData remindersListData,
      String date}) async {
    Utils(context).showProgressLoader();
    var body = {
      "user_id": userDetails.id.toString(),
      "reminder_id": remindersListData.id.toString(),
      "date": date,
      "status": "Active"
      // "password": password,
    };
    try {
      http.Response response = await http.post(CREATE_USER_REMINDER,
          headers: getHeaders(), body: body);
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

  Future<FunnycardsListsResponse> getFunnyCards({@required String type}) async {
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

  Future<TipsListResponse> getTipsList({@required String type = "tips"}) async {
    Utils(context).showProgressLoader();

    try {
      http.Response response = await http.get(
          SUGGESION_TYPE_LIST + "?type=$type",
          headers: getHeaders(token: token));
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
      {@required String type = "ideas"}) async {
    Utils(context).showProgressLoader();

    try {
      http.Response response = await http.get(
          SUGGESION_TYPE_LIST + "?type=$type",
          headers: getHeaders(token: token));
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

  Future<UserWishListResponse> getUserWishList() async {
    Utils(context).showProgressLoader();

    try {
      http.Response response = await http.get(
          USER_WISHLIST + userDetails.id.toString(),
          headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return UserWishListResponse.fromJson(jsonDecode(response.body));
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
  Future<DeleteWishListResponse> deleteUserWishList({String id}) async {
    Utils(context).showProgressLoader();

    try {
      http.Response response = await http.delete(
          DELETE_WISH_LIST + id,
          headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return DeleteWishListResponse.fromJson(jsonDecode(response.body));
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
  Future<DeleteWishListResponse> dELETEUSERREMINDERS({String id}) async {
    Utils(context).showProgressLoader();

    try {
      http.Response response = await http.delete(
          DELETE_USER_REMINDERS + id,
          headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return DeleteWishListResponse.fromJson(jsonDecode(response.body));
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
  Future<SendMsgResponse> sendMsg({String to_id,String MSG}) async {
    Utils(context).showProgressLoader();
var body={
  "from_id":userDetails.id.toString(),
  "to_id":to_id,
  "msg":MSG,
};
    try {
      http.Response response = await http.post(
          SEND_MSG ,
          body: body,
          headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return SendMsgResponse.fromJson(jsonDecode(response.body));
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
  Future<GetMsgResponse> getmsg({String Userid}) async {
    // Utils(context).showProgressLoader();

    try {
      http.Response response = await http.get(
          GET_MSG + Userid,
          headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        print(response.body);
        // Navigator.pop(context);
        return GetMsgResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(response.body);
      }
    } catch (e, s) {
      // Navigator.pop(context);
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
