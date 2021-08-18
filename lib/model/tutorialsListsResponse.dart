class TutorialsListsResponse {
  bool success;
  TutorialsListsData data;
  String message;

  TutorialsListsResponse({this.success, this.data, this.message});

  TutorialsListsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new TutorialsListsData.fromJson(json['data']) : null;
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

class TutorialsListsData {
  String baseUrl;

  TutorialsListsData({this.baseUrl});

  TutorialsListsData.fromJson(Map<String, dynamic> json) {
    baseUrl = json['base_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base_url'] = this.baseUrl;
    return data;
  }
}
