import 'dart:convert';

import 'package:dotenv/dotenv.dart' as dotenv;
import 'package:flutter_test/flutter_test.dart';
import 'package:paytm_api/paytm_api.dart';

void main() {
  setUp(() {
    dotenv.load();
  });
  test('get wallet transactions', () async {
    var trans = await getWalletHistory(
      AccessToken(
        dotenv.env["TEST_ACCESS_TOKEN"],
        DateTime.now().add(Duration(minutes: 5)),
      ),
    );
    print(JsonEncoder.withIndent("\t").convert(trans));
  });
}
