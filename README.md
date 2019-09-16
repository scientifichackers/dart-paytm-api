[![pub package](https://img.shields.io/pub/v/paytm_api.svg?style=for-the-badge)](https://pub.dartlang.org/packages/paytm_api)

# Paytm API

A wrapper on paytm internal APIs, reverse-engineered from the paytm app.

## Usage

1. Generate Access token

```dart
import 'package:paytm_api/paytm_api.dart' as paytm;


var loginToken = await paytm.initLogin('<phone number>');
var validateToken = await paytm.validatePassword(loginToken, <passsword>);
var oauthToken = await paytm.validateOtp(validateToken, <otp>);
var accessToken = await paytm.getAccessToken(oauthToken);
```

2. Use Access token for full access to account

```dart
print(await paytm.getPaytmWalletHistory(accessToken));
```

## Thanks 🙏

- [Charles Proxy](https://www.charlesproxy.com/)
- [Magisk](https://magiskmanager.com/)
- [MagiskTrustUserCerts](https://github.com/NVISO-BE/MagiskTrustUserCerts)
