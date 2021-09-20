class GetUserPartnerDetailsResponse {
  bool success;
  PartnerData data;
  String message;

  GetUserPartnerDetailsResponse({this.success, this.data, this.message});

  GetUserPartnerDetailsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new PartnerData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class PartnerData {
  int id;
  String name;
  var firstName;
  var lastName;
  var dob;
  var middleName;
  String phone;
  String email;
  var username;
  var firstDate;
  var anniversaryDate;
  var state;
  var city;
  var zip;
  var emailVerifiedAt;
  String password;
  String chat;
  String nofication;
  var frequency;
  var questionnaire;
  var dateNights;
  var msgFrequency;
  String status;
  var otp;
  var forgotPasswordOtp;
  var lastLogin;
  String rememberToken;
  String createdAt;
  String updatedAt;
  var deletedAt;
  String picture;
  var socialType;
  var uploaded;
  String premium;
  var celebration_subscribe;
  PartnerData(
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
        this.deletedAt,
        this.picture,
        this.socialType,
        var uploaded,
        String premium,
        var celebration_subscribe,
      });

  PartnerData.fromJson(Map<String, dynamic> json) {
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
    picture = json['picture'];
    socialType = json['social_type'];
    uploaded = json['uploaded'];
    premium = json['premium'];
    celebration_subscribe = json['celebration_subscribe'];
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
    data['picture'] = this.picture;
    data['social_type'] = this.socialType;
    data['uploaded'] = this.uploaded;
    data['premium'] = this.premium;
    data['celebration_subscribe'] = this.celebration_subscribe;
    return data;
  }
}
