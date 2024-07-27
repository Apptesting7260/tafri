class LoginModel {
  bool? status;
  String? message;
  String? uId;
  String? token;

  LoginModel({this.status, this.message,this.token,this.uId});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    uId = json['user_id'].toString();
    token = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
