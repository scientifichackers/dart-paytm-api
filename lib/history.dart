import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:paytm_api/auth.dart';
import 'package:paytm_api/exceptions.dart';

Future getWalletHistory(
  AccessToken token, {
  int offset: 0,
  int limit: 100,
}) async {
  var response = await http.post(
    "https://trust.paytm.in/service/wrapper/userTransactionHistory",
    body: jsonEncode({
      "request": {
        "userGuid": "",
        "startLimit": offset,
        "lastLimit": limit,
        "subWalletParams": {
          "subWalletType": ["PAYTM WALLET"]
        },
        "walletTransactiontype": "ALL"
      }
    }),
    headers: {
      "ssotoken": token.accessToken,
      HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
    },
  );
  if (response.statusCode != 200) {
    throw HttpFailure(response);
  }
  return jsonDecode(response.body);
}
