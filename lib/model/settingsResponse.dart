class SettingsResponse {
  bool success;
  SettingsData data;
  String message;

  SettingsResponse({this.success, this.data, this.message});

  SettingsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new SettingsData.fromJson(json['data'][0]) : null;
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

class SettingsData {
  int id;
  var nofication;
  var chat;
  var frequency;
  var questionnaire;
  var date_nights;
  var msg_frequency;
  var celebration_subscribe;

  SettingsData({this.nofication, this.chat, this.frequency, this.questionnaire});

  SettingsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nofication = json['nofication'];
    chat = json['chat'];
    frequency = json['frequency'];
    questionnaire = json['questionnaire'];
    date_nights = json['date_nights'];
    msg_frequency = json['msg_frequency'];
    celebration_subscribe = json['celebration_subscribe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['nofication'] = this.nofication;
    data['chat'] = this.chat;
    data['frequency'] = this.frequency;
    data['questionnaire'] = this.questionnaire;
    data['date_nights'] = date_nights;
    data['msg_frequency'] = msg_frequency;
    data['celebration_subscribe'] = celebration_subscribe;
    return data;
  }
}
