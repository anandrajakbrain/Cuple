class GetPartnerRequestResponse {
  bool success;
  List<FriendRequestData> date;
  String message;

  GetPartnerRequestResponse({this.success, this.date, this.message});

  GetPartnerRequestResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      date = new List<FriendRequestData>();
      json['data'].forEach((v) {
        date.add(new FriendRequestData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.date != null) {
      data['data'] = this.date.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class FriendRequestData {
  int id;
  int fromId;
  int toId;
  var date;
  String invitationStatus;
  String adminStatus;
  String createdAt;
  String updatedAt;
  var deletedAt;

  FriendRequestData(
      {this.id,
        this.fromId,
        this.toId,
        this.date,
        this.invitationStatus,
        this.adminStatus,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  FriendRequestData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromId = json['from_id'];
    toId = json['to_id'];
    date = json['date'];
    invitationStatus = json['invitation_status'];
    adminStatus = json['admin_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from_id'] = this.fromId;
    data['to_id'] = this.toId;
    data['date'] = this.date;
    data['invitation_status'] = this.invitationStatus;
    data['admin_status'] = this.adminStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
