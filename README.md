# lipa_na_mpesa_online

A dart wrapper around mpesa daraja api from safaricom sandbox.

Ready Methods

- [x] LIPA NA MPESA ONLINE STK PUSH
- [ ] C2BSIMULATE
- [ ] B2B
- [ ] C2B
- [ ] B2C
- [ ] TRANSACTION STATUS
- [ ] ACCOUNT BALANCE
- [ ] REVERSAL

## Requisites

You Will need a few things from Safaricom before development.

1. Consumer Key
2. Consumer Secret
3. Test Credentials for Development/Sanbox environment

- Login or Register as a Safaricom developer [here](https://developer.safaricom.co.ke/login-register) if you haven't.
- Add a new App [here](https://developer.safaricom.co.ke/user/me/apps)
- You will be issued with a Consumer Key and Consumer Secret. You will use these to initiate an Mpesa Instance.
- Obtain Test Credentials [here](https://developer.safaricom.co.ke/test_credentials).
  - The Test Credentials Obtained Are only valid in Sandbox/Development environment. Take note of them.
  - To run in Production Environment you will need real Credentials.
    - To go Live and be issued with real credentials,please refer to [this guide](https://developer.safaricom.co.ke/docs?javascript#going-live)



## Credits

| Contributors |
|--------------|
| [kahdichienja](https://github.com/kahdichienja) |

----------------------------

For help getting started with Flutter, view their
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Getting Started

Add dependency in pubspec.yaml

```yaml
dependencies:
  lipa_na_mpesa_online: [ADD_LATEST_VERSION_HERE]
```

Import in your Flutter app or plain dart app.
in on pressed func, perform 
```dart 
lipanampesa(with all @requred params.)

```


```dart
//Now Support Production URLS
import 'package:lipa_na_mpesa_online/lipa_na_mpesa_online.dart';
import 'package:path/to/your/key.dart' as key;
MpesaService.lipanampesa(
  key.lipa_na_mpesa_passkey,
  key.business_short_code,
  key.consumer_key,
  key.consumer_secret,
  key.phone_number,
  key.transactiontype,
  key.amount,
  key.callbackURL,
  key.accountref,
  key.transactionDesc,
  apiCredintialURL: key.apiCredintialURL_prod,
  apiurlforstkpush: key.apiurlforstkpush_prod)
  .then(
    (value) => {
      //do what you want with the response from the .then(value)
      print('MerchantRequestID = '+value['MerchantRequestID']),
      print('CheckoutRequestID = '+value['CheckoutRequestID']),
      print('ResponseCode = '+value['ResponseCode']),
      print('ResponseDescription = '+value['ResponseDescription']),
      print('CustomerMessage = '+value['CustomerMessage'])
    },
  )

```