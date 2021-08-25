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

  Map<String, dynamic> toJson()  {
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
  int notificationTypeId;
  String msg;
  String status;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  String notificationtype;

  NotificationListData(
      {this.id,
        this.userId,
        this.notificationTypeId,
        this.msg,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.notificationtype});

  NotificationListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    notificationTypeId = json['notification_id'];
    msg = json['msg'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    notificationtype = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['notification_id'] = this.notificationTypeId;
    data['msg'] = this.msg;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['type'] = this.notificationtype;
    return data;
  }
}
