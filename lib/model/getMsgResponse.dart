class GetMsgResponse {
  bool success;
  List<GetMsgData> data;
  String message;

  GetMsgResponse({this.success, this.data, this.message});

  GetMsgResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<GetMsgData>();
      json['data'].forEach((v) {
        data.add(new GetMsgData.fromJson(v));
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

class GetMsgData {
  int id;
  int fromId;
  int toId;
  String msg;
  String createdAt;
  var updatedAt;
  String fromUserName;
  String toUserName;

  GetMsgData(
      {this.id,
        this.fromId,
        this.toId,
        this.msg,
        this.createdAt,
        this.updatedAt,
        this.fromUserName,
        this.toUserName});

  GetMsgData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromId = json['from_id'];
    toId = json['to_id'];
    msg = json['msg'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fromUserName = json['from_user_name'];
    toUserName = json['to_user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from_id'] = this.fromId;
    data['to_id'] = this.toId;
    data['msg'] = this.msg;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['from_user_name'] = this.fromUserName;
    data['to_user_name'] = this.toUserName;
    return data;
  }
}
