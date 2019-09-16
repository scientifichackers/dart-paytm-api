import 'package:dotenv/dotenv.dart' as dotenv;
import 'package:flutter_test/flutter_test.dart';
import 'package:paytm_api/paytm_api.dart';

import 'util.dart';

void main() {
  setUp(() {
    dotenv.load();
  });
  test(
    'login',
    () async {
      var loginToken = await enterUsername(dotenv.env['PAYTM_USERNAME']);
      expect(loginToken, isNotNull);
      expect(loginToken, isNotEmpty);

      var validateToken = await enterPassword(
        loginToken,
        dotenv.env['PAYTM_PASSWORD'],
      );
      expect(validateToken, isNotNull);
      expect(validateToken, isNotEmpty);

      var oauthToken = await enterOTP(validateToken, await getOTPFromHTTP());
      expect(oauthToken, isNotNull);
      expect(oauthToken, isNotEmpty);

      var accessToken = await getAccessToken(oauthToken);
      print(accessToken);
      expect(accessToken, isNotNull);
      expect(accessToken.accessToken, isNotNull);
      expect(accessToken.accessToken, isNotEmpty);
      expect(accessToken.expiresAt, isNotNull);
    },
    timeout: Timeout(Duration(minutes: 5)),
  );
}
