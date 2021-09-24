import 'package:cuple_app/model/verifyOTPResponse.dart';

class RegisterUserResponse {
  bool success;
  String message;
  User user;
  String accessToken;

  RegisterUserResponse(
      {this.success, this.message, this.user, this.accessToken});

  RegisterUserResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['access_token'] = this.accessToken;
    return data;
  }
}

class RegisterData {
  String token;
  RegisterUser user;
  var otp;

  RegisterData({this.token, this.user, this.otp});

  RegisterData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new RegisterUser.fromJson(json['user']) : null;
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['otp'] = this.otp;
    return data;
  }
}

class RegisterUser {
  String name;
  String email;
  String phone;
  String picture;
  String password;
  int otp;
  String updatedAt;
  String createdAt;
  int id;

  RegisterUser(
      {this.name,
        this.email,
        this.phone,
        this.picture,
        this.password,
        this.otp,
        this.updatedAt,
        this.createdAt,
        this.id});

  RegisterUser.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    picture = json['picture'];
    password = json['password'];
    otp = json['otp'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['picture'] = this.picture;
    data['password'] = this.password;
    data['otp'] = this.otp;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
