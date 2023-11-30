import 'dart:convert';

class ResponseWithMessage {
  final String message;
  final int status;

  ResponseWithMessage({required this.message, required this.status});

  factory ResponseWithMessage.fromJson(Map<String, dynamic> json, int status) {
    return ResponseWithMessage(
      message: json["message"] as String,
      status: status,
    );
  }
}

class ResponseWithModel {
  final Map<String, dynamic> data;
  final int status;

  ResponseWithModel({required this.data, required this.status});

  factory ResponseWithModel.fromJson(String responseBody, int status) {
    return ResponseWithModel(
      data: jsonDecode(responseBody),
      status: status,
    );
  }
}
