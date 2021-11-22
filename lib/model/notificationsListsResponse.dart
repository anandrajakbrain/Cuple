class NotificationsListsResponse {
  bool success;
  List<NotificationListData> data;
  String message;

  NotificationsListsResponse({this.success, this.data, this.message});

  NotificationsListsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<NotificationListData>();
      json['data'].forEach((v) {
        data.add(new NotificationListData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class NotificationListData {
  int id;
  int userId;
  int toId;
  String notification;
  String type;
  String createdAt;
  String updatedAt;
  var deletedAt;
  String readable;

  NotificationListData(
      {this.id,
        this.userId,
        this.toId,
        this.notification,
        this.type,
        this.createdAt,
        this.updatedAt,
        this.readable,
        this.deletedAt});

  NotificationListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    toId = json['to_id'];
    notification = json['notification'];
    type = json['type'];
    createdAt = json['created_at'];
    readable = json['readable'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['to_id'] = this.toId;
    data['notification'] = this.notification;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['readable'] = this.readable;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
