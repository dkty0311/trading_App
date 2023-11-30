import 'dart:convert';

import 'package:login_page_1/utils/net/model/response.dart';

import 'package:http/http.dart' as http;

const String host = "http://3.39.231.7";

//로그인
Future<ResponseWithMessage> login(String userID, String password) async {
  http.Response response = await http.post(Uri.parse("$host/user/login"),
      body: jsonEncode({"user_id": userID, "password": password}),
      headers: {"Content-Type": "application/json"});

  String responseBody = utf8.decoder.convert(response.bodyBytes);
  return ResponseWithMessage.fromJson(
      json.decode(responseBody), response.statusCode);
}

//아이디 중복검사
Future<ResponseWithMessage> checkDuplicateID(String userID) async {
  http.Response response = await http.post(
      Uri.parse("$host/user/check/id?id=$userID"),
      headers: {"Content-Type": "application/json"});

  String responseBody = utf8.decoder.convert(response.bodyBytes);
  return ResponseWithMessage.fromJson(
      json.decode(responseBody), response.statusCode);
}

//이메일 요청
Future<ResponseWithMessage> requestEmail(String email) async {
  http.Response response = await http.post(
      Uri.parse("$host/user/email/send?email=$email"),
      headers: {"Content-Type": "application/json"});

  String responseBody = utf8.decoder.convert(response.bodyBytes);
  return ResponseWithMessage.fromJson(
      json.decode(responseBody), response.statusCode);
}

//이메일검증
Future<ResponseWithMessage> verifyEmail(String email, String verifycode) async {
  http.Response response = await http.post(
      Uri.parse("$host/user/email/verify?email=$email&verify_code=$verifycode"),
      headers: {"Content-Type": "application/json"});

  String responseBody = utf8.decoder.convert(response.bodyBytes);
  return ResponseWithMessage.fromJson(
      json.decode(responseBody), response.statusCode);
}

//유저 상세정보 검색
Future<ResponseWithModel> searchProfile(String userID) async {
  http.Response response = await http.get(Uri.parse("$host/user/$userID"),
      headers: {"Content-Type": "application/json"});

  String responseBody = utf8.decoder.convert(response.bodyBytes);
  return ResponseWithModel.fromJson((responseBody), response.statusCode);
}

//프로필이미지 업데이트
Future<ResponseWithMessage> updateImage(
    String userID, String updateImage) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse("$host/user/profile/update?user_id=$userID"),
  );

  request.headers.addAll({'Content-Type': 'multipart/form-data'});

  request.files.add(await http.MultipartFile.fromPath(
    'file',
    updateImage,
  ));

  var response = await http.Response.fromStream(await request.send());

  String responseBody = utf8.decoder.convert(response.bodyBytes);

  return ResponseWithMessage.fromJson(
    json.decode(responseBody),
    response.statusCode,
  );
}

//회원가입
Future<ResponseWithMessage> signUP(String userID, String password, String email,
    String idnum, String name, String phnum) async {
  http.Response response = await http.put(Uri.parse("$host/user/signup"),
      body: jsonEncode({
        "user_id": userID,
        "password": password,
        "name": name,
        "email": email,
        "phone": phnum,
        "idnum": idnum
      }),
      headers: {"Content-Type": "application/json"});

  String responseBody = utf8.decoder.convert(response.bodyBytes);
  return ResponseWithMessage.fromJson(
      json.decode(responseBody), response.statusCode);
}
