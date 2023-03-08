class AuthModel {
  String? message;
  String? accessToken;
  String? refreshToken;

  AuthModel({
    this.message,
    this.accessToken,
    this.refreshToken,
  });

  AuthModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    accessToken = json['data']['token'];
    refreshToken = json['data']['refresh_token']['token'];
  }
}
