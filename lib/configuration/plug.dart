import 'dart:convert';
import 'dart:io';

import 'package:cuple_app/configuration/APIs.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/beforeRegisterResponse.dart';
import 'package:cuple_app/model/createNewReminderResponse.dart';
import 'package:cuple_app/model/deleteWishListResponse.dart';
import 'package:cuple_app/model/findPartnerResponse.dart';
import 'package:cuple_app/model/funnycardsListsResponse.dart';
import 'package:cuple_app/model/getMsgResponse.dart';
import 'package:cuple_app/model/getOTPResponse.dart';
import 'package:cuple_app/model/getPartnerRequestResponse.dart';
import 'package:cuple_app/model/getUserPartnerDetailsResponse.dart';
import 'package:cuple_app/model/ideasListResponse.dart';
import 'package:cuple_app/model/listUserReminderResponse.dart';
import 'package:cuple_app/model/loginResponse.dart';
import 'package:cuple_app/model/notificationsListsResponse.dart';
import 'package:cuple_app/model/registerUserResponse.dart';
import 'package:cuple_app/model/reminder_type_response.dart';
import 'package:cuple_app/model/remindersListsResponse.dart';
import 'package:cuple_app/model/sendInvitationResponse.dart';
import 'package:cuple_app/model/sendMsgResponse.dart';
import 'package:cuple_app/model/sendNotificationResponse.dart';
import 'package:cuple_app/model/sendPartnerRequestResponse.dart';
import 'package:cuple_app/model/showUserResponse.dart';
import 'package:cuple_app/model/suggesiontypeListsResponse.dart';
import 'package:cuple_app/model/tipsListResponse.dart';
import 'package:cuple_app/model/tutorialsListsResponse.dart';
import 'package:cuple_app/model/userFavouritesList.dart';
import 'package:cuple_app/model/userWishListResponse.dart';
import 'package:cuple_app/model/verifyOTPResponse.dart';
import 'package:cuple_app/screens/updateUserResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

User userDetails;
String token;
PartnerData partnerData;
SuggesiontypeListsResponse suggesiontypeListsResponse;
GetPartnerRequestResponse getPartnerRequestResponseGlobal;

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

  Future<BeforeRegisterResponse> beforeRegister(
      {@required String email,
      @required String phone,
      @required String name,
      String first_name,
      String last_name,
      String state,
      String gender}) async {
    Utils(context).showProgressLoader();
    var body = {
      "email": email,
      "phone": phone,
      "name": name,
      "image": "",
      "gender": gender,
      "first_name": first_name,
      "last_name": last_name,
      "state": state,

      // "password":"0",
    };
    try {
      print(body);
      http.Response response =
          await http.post(BEFORE_RAGISTER, headers: getHeaders(), body: body);
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return BeforeRegisterResponse.fromJson(jsonDecode(response.body));
      } else {
        var temp = jsonDecode(response.body);
        if (temp['message'].containsKey("email")) {
          throw Exception(temp['message']['email'][0]);
        } else if (temp['message'].containsKey("phone")) {
          throw Exception(temp['message']['phone'][0]);
        } else {
          throw Exception(temp['message']);
        }
      }
    } catch (e, s) {
      Navigator.pop(context);
     print(s);
      Utils(context).showMessage(
        title: "Error",
        child: Text("$e"),
      );
      throw Exception(e);
    }
  }



  Future<RegisterUserResponse> register(
      {@required String email,
      @required String phone,
      @required String name,
      String first_name,
      String last_name,
      String state,
      String gender}) async {
    Utils(context).showProgressLoader();
    var body = {
      "email": email,
      "phone": phone,
      "name": name,
      "image": "",
      "gender": gender,
      "first_name": first_name,
      "last_name": last_name,
      "state": state,
      "device_token":devieToken,
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
        var temp = jsonDecode(response.body);
        if (temp['message'].containsKey("email")) {
          throw Exception(temp['message']['email'][0]);
        } else if (temp['message'].containsKey("phone")) {
          throw Exception(temp['message']['phone'][0]);
        } else {
          throw Exception(temp['message']);
        }
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
        throw Exception(jsonDecode(response.body)['message']['error']);
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
      "token": devieToken,
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

  Future<LoginResponse> updateSettings(
    var userId,
    var chat,
    var notification,
    var frequency,
    var questionnaire,
    var dateNights,
    var msgFrequency,
    bool celebration_subscribe,
  ) async {
    Utils(context).showProgressLoader();
    var body = {
      "user_id": userId.toString(),
      "chat": chat.toString(),
      "notification": notification.toString(),
      "frequency": frequency != null ? frequency : '',
      "questionnaire": questionnaire != null ? questionnaire : '',
      "date_nights": dateNights != null ? dateNights : '',
      "msg_frequency": msgFrequency != null ? msgFrequency : '',
      "celebration_subscribe": celebration_subscribe ? "1" : "0",
    };
    print(body);
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

  Future<User> updateUserDetails(
      var userId, var name, var email, var phone, var dob) async {
    Utils(context).showProgressLoader();
    var body = {
      "id": userId,
      "name": name,
      "email": email,
      "phone": phone,
      "dob": dob,
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

  Future<UpdateUserResponse> updateUserDetailsWithFormData(
      var userId,
      var name,
      var email,
      var phone,
      var dob,

      File image,
      String mAnniversary,
      String lAnniversary,
      String gender,
      String firstName,
      String lastName,
      String state,

      ) async {
    Utils(context).showProgressLoader();
    var body = {
      "id": userId,
      "name": name,
      "email": email,
      "phone": phone,
      "dob": dob,
    };
    var uri = Uri.parse(UPDATE_USER);
    var request = new http.MultipartRequest("POST", uri);
    try {
      request.fields['id'] = userId.toString();

      request.fields['email'] = email.toString();

      if (phone != null) {
        request.fields['phone'] = phone.toString();

      }
      if (firstName != null) {
        request.fields['first_name'] = firstName.toString();
        request.fields['name'] = firstName+" "+lastName;//name.toString();

      }
      if (lastName != null) {
        request.fields['last_name'] = lastName.toString();
      }
      if (state != null) {
        request.fields['state'] = state.toString();
      }
      if (gender != null) {
        request.fields['gender'] = gender.toString();
      }
      if (dob != null) {
        request.fields['dob'] = dob.toString();
      }
      if (mAnniversary != null) {
        request.fields['anniversary_date'] = mAnniversary.toString();
      }
      if (lAnniversary != null) {
        request.fields['first_date'] = lAnniversary.toString();
      }
      print("Request Parameter");
      print(request.fields);
      if (image != null) {
        request.files.add(await http.MultipartFile.fromPath(
          "image",
          image.path,
          contentType: MediaType('application', "octet-stream"),
        ));
      }
      request.headers.addAll(getHeaders(token: token));
      var reqestReturn = await request.send();
      var response = await http.Response.fromStream(reqestReturn);
      if (reqestReturn.statusCode == 200) {
        Navigator.pop(context);
        print(
            "<-------------------------------------->Updated Data Respopnse<----------------------------------->");
        print(jsonDecode(response.body));
        return UpdateUserResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
      /* http.Response response =
      await http.post(UPDATE_USER, headers: getHeaders(), body: body);
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return User.fromJson(jsonDecode(response.body)["data"]);
      } else {
        throw Exception(response.body);
      }*/
    } catch (e, s) {
      Navigator.pop(context);
      Utils(context).showMessage(
        title: "Error",
        child: Text("$e"),
      );
      throw Exception(e);
    }
  }

  Future<VerifyOTPResponse> loginWithSocialMedia(
      var socialType, var name, var email, var phone, var image) async {
    Utils(context).showProgressLoader();
    var body = {
      "social_type": socialType,
      "name": name,
      "email": email,
      "phone": phone,
      "image": image,
    };
    try {
      http.Response response =
          await http.post(SOCIAL_LOGIN, headers: getHeaders(), body: body);
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return VerifyOTPResponse.fromJson(jsonDecode(response.body));
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

  Future<NotificationsListsResponse> getNotificationList(var id,
      {@required String name}) async {
    Utils(context).showProgressLoader();
    var body = {
      "name": name,

      // "password": password,
    };
    try {
      http.Response response = await http.get(
          NOTIFICATION_LIST + "?user_id=$id",
          headers: getHeaders(token: token));
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

  Future<NotificationsListsResponse> deleteNotification(var id,
      {@required String name}) async {
    Utils(context).showProgressLoader();
    var body = {
      "name": name,

      // "password": password,
    };
    try {
      http.Response response = await http.delete(
          DELETE_USER_NOTIFICATION + "?id=$id",
          headers: getHeaders(token: token));
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

  Future<NotificationsListsResponse> deleteAllNotifications(var delIds,
      {@required String name}) async {
    Utils(context).showProgressLoader();
    var body = {
      "name": name,

      // "password": password,
    };
    try {
      http.Response response = await http.delete(
          DELETE_ALL_USER_NOTIFICATION + "?$delIds",
          headers: getHeaders(token: token));
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
      {@required int type}) async {
    Utils(context).showProgressLoader();

    try {
      http.Response response = await http.get(
          REMINDERS_LIST + "?reminders_type_id=$type",
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

  Future<RemindersTypeResponse> getreminderType() async {
    Utils(context).showProgressLoader();

    try {
      http.Response response =
          await http.get(REMINDER_TYPE, headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return RemindersTypeResponse.fromJson(jsonDecode(response.body));
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

  Future<CreateNewReminderResponse> createNewReminder({
    @required String category,
    RemindersListData remindersListData,
    String date,
    String name,
    String customize_name,
  }) async {
    Utils(context).showProgressLoader();
    var body = {
      "user_id": userDetails.id.toString(),
      "reminder_id": remindersListData.id.toString(),
      "date": date,
      "status": "Active",
      "name": name,
      "favourite": "no",
      "customize_name": customize_name,
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

  Future<TutorialsListsResponse> getTutorialList() async {
    Utils(context).showProgressLoader();

    try {
      http.Response response =
          await http.get(TUTORIALS_LIST, headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return TutorialsListsResponse.fromJson(jsonDecode(response.body));
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
      http.Response response =
          await http.get(SUGGESION_TYPE_LIST + "?category_id=2",
              //According to Suggestion Type 2 is Love Tips Id
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
          SUGGESION_TYPE_LIST +
              "?category_id=1&auth_id=" + //According To Suggestion Type Date Ideas id is 1
              userDetails.id.toString(),
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

  Future<SendPartnerRequestResponse> addToWishList(
      {String suggestionId}) async {
    Utils(context).showProgressLoader();

    try {
      var body = {
        "suggesion_id": suggestionId,
        "user_id": userDetails.id.toString(),
      };
      http.Response response = await http.post(ADD_TO_WISHLIST,
          body: body, headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return SendPartnerRequestResponse.fromJson(jsonDecode(response.body));
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

  Future<UserWishListResponse> getPartnerWishList({String partnerID}) async {
    Utils(context).showProgressLoader();

    try {
      http.Response response = await http.get(
          USER_WISHLIST + partnerID.toString(),
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
    print(DELETE_WISH_LIST + id);
    try {
      http.Response response = await http.delete(DELETE_WISH_LIST + id,
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
      http.Response response = await http.delete(DELETE_USER_REMINDERS + id,
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

  Future<SendMsgResponse> sendMsg({String to_id, String MSG}) async {
    Utils(context).showProgressLoader();
    var body = {
      "from_id": userDetails.id.toString(),
      "to_id": to_id,
      "msg": MSG,
    };
    try {
      http.Response response = await http.post(SEND_MSG,
          body: body, headers: getHeaders(token: token));
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
      http.Response response =
          await http.get(GET_MSG + Userid, headers: getHeaders(token: token));
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

  Future<GetUserPartnerDetailsResponse> getUserPartnerDetails(
      {String Userid}) async {
    // Utils(context).showProgressLoader();

    try {
      http.Response response = await http.get(GET_USER_PARTNER_DETAIL + Userid,
          headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        print(response.body);
        // Navigator.pop(context);
        return GetUserPartnerDetailsResponse.fromJson(
            jsonDecode(response.body));
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

  Future<SuggesiontypeListsResponse> getSuggestionType() async {
    Utils(context).showProgressLoader();

    try {
      http.Response response = await http.get(SUGGESTION_TYPE_LIST_FOR_HOME,
          // body: body,
          headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        print("Suggestion Type");
        print(response.body);
        Navigator.pop(context);
        return SuggesiontypeListsResponse.fromJson(jsonDecode(response.body));
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

  /*------------------------------------PARTNER---------------------*/
  Future<FindPartnerResponse> findPartner({String search_key}) async {
    Utils(context).showProgressLoader();

    try {
      var body = {
        "search_key": search_key,
      };
      print("Search Partner");
      print(body);
      http.Response response = await http.post(FIND_PARTNER,
          body: body, headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return FindPartnerResponse.fromJson(jsonDecode(response.body));
      } else {
        var temp = jsonDecode(response.body);
        if (temp['message'].containsKey('search_key')) {
          throw Exception(temp['message']['search_key'][0]);
        } else {
          throw Exception(temp['message']);
        }
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

  Future<SendPartnerRequestResponse> sendPartnerRequest(
      {String userId, String friendId}) async {
    Utils(context).showProgressLoader();

    try {
      http.Response response = await http.post(
          SEND_PARTNER_REQUEST + "?from_id=$userId&to_id=$friendId",
          // body: body,
          headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return SendPartnerRequestResponse.fromJson(jsonDecode(response.body));
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

  Future<SendPartnerRequestResponse> acceptPartnerRequest(
      {String matchId}) async {
    Utils(context).showProgressLoader();

    try {

      var body = {
        "match_id": matchId,
      };
      print(body);
      http.Response response = await http.post(ACCEPT_PARTNER_REQUEST,
          body: body, headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        print(response.body);

        Navigator.pop(context);

        return SendPartnerRequestResponse.fromJson(jsonDecode(response.body));
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

  Future<SendPartnerRequestResponse> cancelPartnerRequest(
      {String matchId}) async {
    Utils(context).showProgressLoader();

    try {
      http.Response response =
          await http.delete(CANCEL_PARTNER_REQUEST + matchId,
              // body: body,
              headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return SendPartnerRequestResponse.fromJson(jsonDecode(response.body));
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

  Future<GetPartnerRequestResponse> getFriendRequest() async {
    Utils(context).showProgressLoader();

    try {
      /*var body={
        "search_key":search_key,
      };*/
      print(GET_PARTNER_REQUEST + userDetails.id.toString());
      http.Response response =
          await http.get(GET_PARTNER_REQUEST + userDetails.id.toString(),
              // body: body,
              headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return GetPartnerRequestResponse.fromJson(jsonDecode(response.body));
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
  Future<SendInvitationResponse> sendInvitation({@required String email}) async {
    Utils(context).showProgressLoader();

    try {
      var body={
        "email":email,
        "name":userDetails.name,
      };
      print(SEND_INVITES);
      http.Response response =
          await http.post(SEND_INVITES,
              body: body,
              headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return SendInvitationResponse.fromJson(jsonDecode(response.body));
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

  Future<ShowUserResponse> showUser({@required String userID}) async {
    Utils(context).showProgressLoader();

    try {
      /*var body={
        "search_key":search_key,
      };*/
      http.Response response = await http.get(SHOW_USER + userID.toString(),
          // body: body,
          headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return ShowUserResponse.fromJson(jsonDecode(response.body));
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

  /*-------------------------------Favourites--------------------*/
  //TODO:Favourites

  Future<SendPartnerRequestResponse> addToFavourites(
      {String reminderId, String action = "yes"}) async {
    Utils(context).showProgressLoader();

    try {
      var body = {
        "id": reminderId,
        "favourite": action,
      };
      http.Response response = await http.post(ADD_TO_FAVOURITES,
          body: body, headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return SendPartnerRequestResponse.fromJson(jsonDecode(response.body));
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

  Future<UserFavouritesList> getUserFavouritesList({String partnerID}) async {
    Utils(context).showProgressLoader();

    try {
      /*var body={
        "search_key":search_key,
      };*/
      http.Response response = await http.get(
          USER_FAVOURITES_LIST +
              userDetails.id.toString() +
              "&partner_id=$partnerID",
          // body: body,
          headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context);
        return UserFavouritesList.fromJson(jsonDecode(response.body));
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

/*------------------------NOTIFICATION WITH FCM-------------------------*/
  Future<SendNotificationResponse> sendNotification(
      {String sendToUID, String title, String msg}) async {
    try {
      var body = {
        "id": sendToUID,
        "title": title,
        "body": msg,
      };
      http.Response response = await http.post(SEND_NOTIFICATION,
          body: body,
          // body: body,
          headers: getHeaders(token: token));
      if (response.statusCode == 200) {
        return SendNotificationResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(jsonDecode(response.body));
      }
    } catch (e, s) {
      print(e);
      print(s);
      Utils(context).showMessage(
        title: "Error",
        child: Text("$e"),
      );
    }
  }

/*------------------------NOTIFICATION WITH FCM-------------------------*/
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
