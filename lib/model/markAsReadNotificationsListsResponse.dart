class MarkAsReadNotificationsListsResponse {
  bool success;
  List<Data> data;
  String message;

  MarkAsReadNotificationsListsResponse({this.success, this.data, this.message});

  MarkAsReadNotificationsListsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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

class Data {
  int id;
  int userId;
  int toId;
  String notification;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  String type;
  String readable;

  Data(
      {this.id,
        this.userId,
        this.toId,
        this.notification,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.type,
        this.readable});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    toId = json['to_id'];
    notification = json['notification'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    type = json['type'];
    readable = json['readable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['to_id'] = this.toId;
    data['notification'] = this.notification;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['type'] = this.type;
    data['readable'] = this.readable;
    return data;
  }
}
