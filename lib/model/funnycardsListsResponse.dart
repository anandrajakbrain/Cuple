class FunnycardsListsResponse {
  bool success;
  FunnycardsListData data;
  String message;

  FunnycardsListsResponse({this.success, this.data, this.message});

  FunnycardsListsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new FunnycardsListData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class FunnycardsListData {
  String baseUrl;

  FunnycardsListData({this.baseUrl});

  FunnycardsListData.fromJson(Map<String, dynamic> json) {
    baseUrl = json['base_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base_url'] = this.baseUrl;
    return data;
  }
}
