[![pub package](https://img.shields.io/pub/v/paytm_api.svg?style=for-the-badge)](https://pub.dartlang.org/packages/paytm_api)

# Paytm API

A wrapper on paytm internal APIs, reverse-engineered from the paytm app.

## Usage

1. Generate Access token

```dart
import 'package:paytm_api/paytm_api.dart' as paytm;


var loginToken = await paytm.login('<phone number>', '<password>');
var oauthToken = await paytm.enterOTP(loginToken, '<otp>');
var accessToken = await paytm.getAccessToken(oauthToken);
```

2. Use Access token for full access to account

```dart
print(await paytm.getWalletHistory(accessToken));
```

## Thanks 🙏

- [Charles Proxy](https://www.charlesproxy.com/)
- [Magisk](https://magiskmanager.com/)
- [MagiskTrustUserCerts](https://github.com/NVISO-BE/MagiskTrustUserCerts)
