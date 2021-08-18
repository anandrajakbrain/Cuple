class RemindersListsResponse {
  bool success;
  List<RemindersListData> data;
  String message;

  RemindersListsResponse({this.success, this.data, this.message});

  RemindersListsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<RemindersListData>();
      json['data'].forEach((v) {
        data.add(new RemindersListData.fromJson(v));
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

class RemindersListData {
  int id;
  String category;
  String name;
  String status;
  String createdAt;
  String updatedAt;
  Null deletedAt;

  RemindersListData(
      {this.id,
        this.category,
        this.name,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  RemindersListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
