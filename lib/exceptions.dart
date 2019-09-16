import 'package:http/http.dart' as http;

class HttpFailure implements Exception {
  final http.Response response;

  HttpFailure(this.response);

  @override
  String toString() {
    return "$runtimeType { statusCode: ${response.statusCode}, body: ${response.body} }";
  }
}

class OtpLimitReached implements Exception {
  final String status;
  final String responseCode;
  final String message;

  OtpLimitReached(Map json)
      : status = json['status'],
        responseCode = json['responseCode'],
        message = json['message'];

  @override
  String toString() {
    return "$runtimeType { status: $status, responseCode: $responseCode, message: $message }";
  }
}
