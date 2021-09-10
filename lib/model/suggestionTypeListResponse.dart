class SuggestionTypeListResponse {
  bool success;
  List<SugesstionTypeData> data;
  String message;

  SuggestionTypeListResponse({this.success, this.data, this.message});

  SuggestionTypeListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<SugesstionTypeData>();
      json['data'].forEach((v) {
        data.add(new SugesstionTypeData.fromJson(v));
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

class SugesstionTypeData {
  int id;
  int parent;
  String name;
  String status;
  String createdAt;
  String updatedAt;
  var deletedAt;

  SugesstionTypeData(
      {this.id,
        this.parent,
        this.name,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  SugesstionTypeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parent = json['parent'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent'] = this.parent;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
