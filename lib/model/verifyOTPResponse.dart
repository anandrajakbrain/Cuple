class VerifyOTPResponse {
  bool success;
  String message;
  User user;
  String accessToken;

  VerifyOTPResponse({this.success, this.message, this.user, this.accessToken});

  VerifyOTPResponse.fromJson(Map<String, dynamic> json) {
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

class User {
  int id;
  String name;
  String firstName;
  String lastName;
  String dob;
  String middleName;
  String phone;
  String email;
  String username;
  String firstDate;
  String anniversaryDate;
  String state;
  String city;
  String zip;
  String emailVerifiedAt;
  String password;
  String chat;
  String nofication;
  String frequency;
  String questionnaire;
  String dateNights;
  String msgFrequency;
  String status;
  String otp;
  String forgotPasswordOtp;
  String lastLogin;
  String rememberToken;
  String createdAt;
  String updatedAt;
  String deletedAt;

  User(
      {this.id,
        this.name,
        this.firstName,
        this.lastName,
        this.dob,
        this.middleName,
        this.phone,
        this.email,
        this.username,
        this.firstDate,
        this.anniversaryDate,
        this.state,
        this.city,
        this.zip,
        this.emailVerifiedAt,
        this.password,
        this.chat,
        this.nofication,
        this.frequency,
        this.questionnaire,
        this.dateNights,
        this.msgFrequency,
        this.status,
        this.otp,
        this.forgotPasswordOtp,
        this.lastLogin,
        this.rememberToken,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    dob = json['dob'];
    middleName = json['middle_name'];
    phone = json['phone'];
    email = json['email'];
    username = json['username'];
    firstDate = json['first_date'];
    anniversaryDate = json['anniversary_date'];
    state = json['state'];
    city = json['city'];
    zip = json['zip'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    chat = json['chat'];
    nofication = json['nofication'];
    frequency = json['frequency'];
    questionnaire = json['questionnaire'];
    dateNights = json['date_nights'];
    msgFrequency = json['msg_frequency'];
    status = json['status'];
    otp = json['otp'];
    forgotPasswordOtp = json['forgot_password_otp'];
    lastLogin = json['last_login'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['dob'] = this.dob;
    data['middle_name'] = this.middleName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['username'] = this.username;
    data['first_date'] = this.firstDate;
    data['anniversary_date'] = this.anniversaryDate;
    data['state'] = this.state;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['password'] = this.password;
    data['chat'] = this.chat;
    data['nofication'] = this.nofication;
    data['frequency'] = this.frequency;
    data['questionnaire'] = this.questionnaire;
    data['date_nights'] = this.dateNights;
    data['msg_frequency'] = this.msgFrequency;
    data['status'] = this.status;
    data['otp'] = this.otp;
    data['forgot_password_otp'] = this.forgotPasswordOtp;
    data['last_login'] = this.lastLogin;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
