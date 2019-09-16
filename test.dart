import 'dart:convert';

import 'package:dotenv/dotenv.dart' as dotenv;
import 'package:paytm_api/paytm_api.dart';

main() async {
  dotenv.load();
  var token = AccessToken(
    dotenv.env["TEST_ACCESS_TOKEN"],
    DateTime.now().add(Duration(minutes: 5)),
  );
//  var trans = await getPaytmWalletHistory(token);
  var trans = await sendMoney("1", "8764022384", token);
  print(JsonEncoder.withIndent("\t").convert(trans));
}
