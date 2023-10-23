
class Result {
  bool? result;
  dynamic message;
  dynamic token;

  Result({this.result, this.message, this.token});

  Result.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    token = json['token']; 
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['message'] = message;
    data['token'] = token;
    return data;
  }
}
