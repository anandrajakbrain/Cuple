class IdeasListResponse {
  bool success;
  List<IdeasData> data;
  String message;

  IdeasListResponse({this.success, this.data, this.message});

  IdeasListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<IdeasData>();
      json['data'].forEach((v) {
        data.add(new IdeasData.fromJson(v));
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

class IdeasData {
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

  IdeasData(
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

  IdeasData.fromJson(Map<String, dynamic> json) {
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
