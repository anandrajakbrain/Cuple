class CheckUserStatusResponse {
  bool success;
  PartnerStatusData data;
  String message;

  CheckUserStatusResponse({this.success, this.data, this.message});

  CheckUserStatusResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new PartnerStatusData.fromJson(json['data']) : null;
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

class PartnerStatusData {
  String activeStatus;

  PartnerStatusData({this.activeStatus});

  PartnerStatusData.fromJson(Map<String, dynamic> json) {
    activeStatus = json['active_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active_status'] = this.activeStatus;
    return data;
  }
}
