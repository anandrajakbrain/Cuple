class ListUserReminderResponse {
  bool success;
  List<UserListReminderData> data;
  String message;

  ListUserReminderResponse({this.success, this.data, this.message});

  ListUserReminderResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<UserListReminderData>();
      json['data'].forEach((v) {
        data.add(new UserListReminderData.fromJson(v));
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

class UserListReminderData {
  int id;
  String customize_name;
  int userId;
  int reminderId;
  String date;
  String status;
  var createdAt;
  var updatedAt;
  var deletedAt;
  String favourite;
  String name;

  UserListReminderData(
      {this.id,
        this.customize_name,
        this.userId,
        this.reminderId,
        this.date,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.favourite,
        this.name});

  UserListReminderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customize_name = json['customize_name'];
    userId = json['user_id'];
    reminderId = json['reminder_id'];
    date = json['date'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    favourite = json['favourite'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customize_name'] = this.customize_name;
    data['user_id'] = this.userId;
    data['reminder_id'] = this.reminderId;
    data['date'] = this.date;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['favourite'] = this.favourite;
    data['name'] = this.name;
    return data;
  }
}
