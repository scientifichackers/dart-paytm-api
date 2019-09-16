import 'dart:async';
import 'dart:io';

Future<String> getOTPFromHTTP() async {
  var server = await HttpServer.bind(InternetAddress.anyIPv4, 4050);
  try {
    print(
      "\nPlease enter the OTP using: \n\t\$ curl http://localhost:${server.port}/<code>\n",
    );
    await for (var request in server) {
      String code;
      try {
        code = request.uri.pathSegments.first;
      } on StateError {}
      print('Received OTP: "$code"');
      if (code?.isEmpty ?? true) {
        request.response
          ..statusCode = HttpStatus.badRequest
          ..write("Bad request: Path does not contain OTP!")
          ..close();
        continue;
      }

      request.response
        ..write("OK")
        ..close();
      return code;
    }
  } finally {
    server.close();
  }
}
