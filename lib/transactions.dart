import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:paytm_api/auth.dart';
import 'package:paytm_api/exceptions.dart';

Future sendMoney(String amount, String to, AccessToken token) async {
  var response = await http.post(
    "https://trust.paytm.in/wallet-web/sendMoney",
    body: jsonEncode({
      "request": {
        "isToVerify": "0",
        "isLimitApplicable": "0",
        "amount": amount,
        "payeePhoneNumber": to,
        "currencyCode": "INR",
        "comment": "Sent using dart Paytm API",
        "mode": "RECENT_NUMBER"
      },
      "ipAddress": "127.0.0.1",
      "platformName": "PayTM",
      "operationType": "P2P_TRANSFER",
      "channel": "MP-ANDROID",
      "version": "8.3.3"
    }),
    headers: {
      "risk_extended_info":
          '{"isContact":false,"isRooted":false,"otpReadFlag":false}',
      "ssotoken": token.accessToken,
      HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
    },
  );
  if (response.statusCode != 200) {
    throw HttpFailure(response);
  }
  return jsonDecode(response.body);
}
