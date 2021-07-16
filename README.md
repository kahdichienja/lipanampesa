# lipa_na_mpesa_online

A dart wrapper around mpesa daraja api from safaricom sandbox and production.

Ready Methods

- [x] LIPA NA MPESA ONLINE STK PUSH


## 1. Sand Box:Requisites

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

## 2. Live:Requisites
1. Consumer Key
2. Consumer Secret
3. Production Credentials which is normally sent to the account email you use to go live with including the lipanampesa pass key. and till/paybill number your are going live with.
3. Switch to the orginasation tab, and obtain the Consumer Key and Consumer Secret,
4. The API URLS will also be sent to you by safaricom from the API support email.

Download test cases when they are creating a sandbox app. The test cases are in an Excel spreadsheet which the you will fill with results from the API calls they make for each test scenarios.

Once the test case scenarios have been duly filled, the you will upload the filled Excel spreadsheet during the ‘Go Live’ process. API support team will then review the test cases and then either approve or reject the production app.

NOTE: IF YOU ARE STACK REACH ME THROUGH MAIL:computerscience2.10@gmail.com SUBJECT:LIPANAMPESA STKPUSH PUB.DEV.
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
      lipanampesapasskey: key.lipa_na_mpesa_passkey,
      businessshortcode: key.business_short_code,
      consumerkey: key.consumer_key,
      consumersecret: key.consumer_secret,
      phonenumber: key.phone_number,
      transactionType: key.transactiontype,
      amount: key.amount,
      callBackURL: key.callbackURL_sand,
      accountReference: key.accountref,
      transactionDesc: key.transactionDesc,
      isProduction: false
    ).then(
      (C2BInitialMpesaRespoce value) => {
        print('MerchantRequestID = ' + value.merchantRequestID),
        print('CheckoutRequestID = ' + value.checkoutRequestID),
        print('ResponseCode = ' + value.responseCode),
        print('ResponseDescription = ' + value.responseDescription),
        print('CustomerMessage = ' + value.customerMessage),
      },
    ),

```