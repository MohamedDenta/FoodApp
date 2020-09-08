import 'package:food_app/scr/models/user.dart';

class AuthResponse {
  int _code;
  String _message;
  String _type;
  UserModel _user;
  // getters
  int get code => _code;
  String get message => _message;
  String get type => _type;
  UserModel get user => _user;

  // setters
  set code(int code) => _code;
  set message(String message) => _message;
  set type(String type) => _type;

  set user(UserModel user) => _user;
  AuthResponse();
  AuthResponse.fromJson(Map<String, dynamic> json, int c) {
    _type = json['type'];
    _message = json['message'];
    _user = UserModel.fromJson(json['user']);
    _code = c;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = _message;
    data['user'] = _user.toJson();
    data['code'] = _code;
    return data;
  }
}
