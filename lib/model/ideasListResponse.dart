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
  int suggesionTypeId;
  String category;
  String content;
  String image;
  var link;
  String status;
  String createdAt;
  String updatedAt;
  var deletedAt;
  String suggesiontype;
  String name;

  IdeasData(
      {this.id,
        this.suggesionTypeId,
        this.category,
        this.content,
        this.image,
        this.link,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.suggesiontype,
      this.name});

  IdeasData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    suggesionTypeId = json['suggesion_type_id'];
    category = json['category'];
    content = json['content'];
    image = json['image'];
    link = json['link'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    suggesiontype = json['suggesiontype'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['suggesion_type_id'] = this.suggesionTypeId;
    data['category'] = this.category;
    data['content'] = this.content;
    data['image'] = this.image;
    data['link'] = this.link;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['suggesiontype'] = this.suggesiontype;
    data['name'] = this.name;
    return data;
  }
}
