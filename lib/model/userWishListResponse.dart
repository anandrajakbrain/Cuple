class UserWishListResponse {
  bool success;
  List<UserWishListData> data;
  String message;

  UserWishListResponse({this.success, this.data, this.message});

  UserWishListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<UserWishListData>();
      json['data'].forEach((v) {
        data.add(new UserWishListData.fromJson(v));
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

class UserWishListData {
  int id;
  int userId;
  String image;
  String description;
  String link;
  int titleId;
  Null createdAt;
  Null updatedAt;
  String name;

  UserWishListData(
      {this.id,
        this.userId,
        this.image,
        this.description,
        this.link,
        this.titleId,
        this.createdAt,
        this.updatedAt,
        this.name});

  UserWishListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    image = json['image'];
    description = json['description'];
    link = json['link'];
    titleId = json['title_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['image'] = this.image;
    data['description'] = this.description;
    data['link'] = this.link;
    data['title_id'] = this.titleId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    return data;
  }
}
