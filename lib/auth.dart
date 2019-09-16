import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:paytm_api/exceptions.dart';

var commonHeaders = {
  HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
  HttpHeaders.hostHeader: "accounts.paytm.com",
  HttpHeaders.authorizationHeader:
      "Basic bWFya2V0LWFwcDo5YTA3MTc2Mi1hNDk5LTRiZDktOTE0YS00MzYxZTdjM2Y0YmM=",
};

class AccessToken {
  final String accessToken;
  final DateTime expiresAt;

  const AccessToken(this.accessToken, this.expiresAt);

  @override
  String toString() {
    return "AccessToken { accessToken: $accessToken, expiresAt: $expiresAt }";
  }
}

Future<String> login(String username, String password) async {
  return await enterPassword(await enterUsername(username), password);
}

Future<String> enterUsername(String username) async {
  var response = await http.post(
    "https://accounts.paytm.com/simple/login/init",
    body: jsonEncode({"loginId": username, "flow": "login"}),
    headers: commonHeaders,
  );
  if (response.statusCode != 200) {
    throw HttpFailure(response);
  }
  print(response.body);
  return jsonDecode(response.body)["stateToken"];
}

Future<String> enterPassword(String stateToken, String password) async {
  var response = await http.post(
    "https://accounts.paytm.com/simple/login/validate/password",
    body: jsonEncode({"password": password, "stateToken": stateToken}),
    headers: commonHeaders,
  );
  if (response.statusCode != 200) {
    throw HttpFailure(response);
  }
  print(response.body);
  var json = jsonDecode(response.body);
  if (json["responseCode"] == "708") {
    throw OtpLimitReached(json);
  }
  return json["stateToken"];
}

Future<String> enterOTP(String stateToken, String otp) async {
  var response = await http.post(
    "https://accounts.paytm.com/simple/login/validate/otp",
    body: jsonEncode({"otp": otp, "stateToken": stateToken}),
    headers: commonHeaders,
  );
  if (response.statusCode != 200) {
    throw HttpFailure(response);
  }
  print(response.body);
  return jsonDecode(response.body)["oauthCode"];
}

Future<AccessToken> getAccessToken(String oauthCode) async {
  print(oauthCode);
  var response = await http.post(
    "https://accounts.paytm.com/oauth2/token",
    body: "code=$oauthCode&scope=paytm&grant_type=authorization_code",
    headers: commonHeaders,
  );
  if (response.statusCode != 200) {
    throw HttpFailure(response);
  }
  var json = jsonDecode(response.body);
  return AccessToken(
    json["access_token"],
    DateTime.now().add(Duration(seconds: json["expires"])),
  );
}
