class InquiryFormResponse {
  bool success;
  InquiryData data;
  String message;

  InquiryFormResponse({this.success, this.data, this.message});

  InquiryFormResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new InquiryData.fromJson(json['data']) : null;
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

class InquiryData {
  String message;
  String userName;

  InquiryData({this.message, this.userName});

  InquiryData.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    data['user_name'] = this.userName;
    return data;
  }
}
