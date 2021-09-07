class TutorialsListsResponse {
  bool success;
  List<TutorialData> data;
  String message;

  TutorialsListsResponse({this.success, this.data, this.message});

  TutorialsListsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<TutorialData>();
      json['data'].forEach((v) {
        data.add(new TutorialData.fromJson(v));
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

class TutorialData {
  int id;
  String name;
  String image;
  String videoLink;
  int order;
  String content;
  String status;
  String createdAt;
  String updatedAt;
  Null deletedAt;

  TutorialData(
      {this.id,
        this.name,
        this.image,
        this.videoLink,
        this.order,
        this.content,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  TutorialData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    videoLink = json['video_link'];
    order = json['order'];
    content = json['content'];
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
    data['video_link'] = this.videoLink;
    data['order'] = this.order;
    data['content'] = this.content;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
