class FunnycardsListsResponse {
  bool success;
  List<FunnyCardData> data;
  String message;

  FunnycardsListsResponse({this.success, this.data, this.message});

  FunnycardsListsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<FunnyCardData>();
      json['data'].forEach((v) {
        data.add(new FunnyCardData.fromJson(v));
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

class FunnyCardData {
  int id;
  String name;
  String image;
  String status;
  String createdAt;
  String updatedAt;
  var deletedAt;

  FunnyCardData(
      {this.id,
        this.name,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  FunnyCardData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
