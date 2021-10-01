class StatesResponse {
  bool success;
  List<StatesData> data;
  String message;

  StatesResponse({this.success, this.data, this.message});

  StatesResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<StatesData>();
      json['data'].forEach((v) {
        data.add(new StatesData.fromJson(v));
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

class StatesData {
  int id;
  String country_name;
  String state_name;
  String code;
  String status;
  String updated_at;
  String created_at;
  var deleted_at;

  StatesData({this.id, this.country_name, this.state_name, this.code, this.status, this.created_at, this.updated_at, this.deleted_at});

  StatesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country_name = json['country_name'];
    state_name = json['state_name'];
    code = json['code'];
    status = json['status'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    deleted_at = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['country_name'] = this.country_name;
    data['state_name'] = this.state_name;
    data['code'] = this.code;
    data['status'] = this.status;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
    data['deleted_at'] = deleted_at;
    return data;
  }
}
