class FindPartnerResponse {
  bool success;
  Alldata alldata;
  String message;

  FindPartnerResponse({this.success, this.alldata, this.message});

  FindPartnerResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    alldata =
    json['alldata'] != null ? new Alldata.fromJson(json['alldata']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.alldata != null) {
      data['alldata'] = this.alldata.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Alldata {
  int currentPage;
  List<FindPartnerData> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  Null nextPageUrl;
  String path;
  int perPage;
  Null prevPageUrl;
  int to;
  int total;

  Alldata(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Alldata.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<FindPartnerData>();
      json['data'].forEach((v) {
        data.add(new FindPartnerData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class FindPartnerData {
  int id;
  String name;
  var firstName;
  var lastName;
  var dob;
  var middleName;
  String phone;
  String email;
  var gender;
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

  FindPartnerData(
      {this.id,
        this.name,
        this.firstName,
        this.lastName,
        this.dob,
        this.middleName,
        this.phone,
        this.email,
        this.gender,
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
        this.uploaded,
        this.premium});

  FindPartnerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    dob = json['dob'];
    middleName = json['middle_name'];
    phone = json['phone'];
    email = json['email'];
    gender = json['gender'];
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
    data['gender'] = this.gender;
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
    return data;
  }
}
