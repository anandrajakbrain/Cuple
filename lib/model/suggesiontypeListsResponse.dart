class SuggesiontypeListsResponse {
  bool success;
  List<SuggesiontypeListsData> data;
  String message;

  SuggesiontypeListsResponse({this.success, this.data, this.message});

  SuggesiontypeListsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<SuggesiontypeListsData>();
      json['data'].forEach((v) {
        data.add(new SuggesiontypeListsData.fromJson(v));
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

class SuggesiontypeListsData {
  int id;
  String name;
  String status;
  String createdAt;
  String updatedAt;
  var deletedAt;

  SuggesiontypeListsData(
      {this.id,
        this.name,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  SuggesiontypeListsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
