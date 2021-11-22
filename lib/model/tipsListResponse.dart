class TipsListResponse {
  bool success;
  List<TipsData> data;
  String message;

  TipsListResponse({this.success, this.data, this.message});

  TipsListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<TipsData>();
      json['data'].forEach((v) {
        data.add(new TipsData.fromJson(v));
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

class TipsData {
  int id;
  String name;
  String content;
  String image;
  String link;
  int order;
  String status;
  String createdAt;
  String updatedAt;
  var deletedAt;

  TipsData(
      {this.id,
        this.name,
        this.content,
        this.image,
        this.link,
        this.order,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  TipsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    content = json['content'];
    image = json['image'];
    link = json['link'];
    order = json['order'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['content'] = this.content;
    data['image'] = this.image;
    data['link'] = this.link;
    data['order'] = this.order;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
