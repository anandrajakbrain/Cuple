class UserFavouritesList {
  bool success;
  List<FavouritesData> data;
  String message;

  UserFavouritesList({this.success, this.data, this.message});

  UserFavouritesList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<FavouritesData>();
      json['data'].forEach((v) {
        data.add(new FavouritesData.fromJson(v));
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

class FavouritesData {
  int userId;
  int partner;
  String type;
  String remindername;
  int reminderid;
  String reminderDate;

  FavouritesData(
      {this.userId,
        this.partner,
        this.type,
        this.remindername,
        this.reminderid,
        this.reminderDate});

  FavouritesData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    partner = json['partner'];
    type = json['type'];
    remindername = json['remindername'];
    reminderid = json['reminderid'];
    reminderDate = json['reminder_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['partner'] = this.partner;
    data['type'] = this.type;
    data['remindername'] = this.remindername;
    data['reminderid'] = this.reminderid;
    data['reminder_date'] = this.reminderDate;
    return data;
  }
}
