## Getting Started

Add dependency in pubspec.yaml

```yaml
dependencies:
  lipa_na_mpesa_online: [ADD_LATEST_VERSION_HERE]
```

# LIPANAMPESA ONLINE STK PUSH C2B

## 1. Create An App in Safaricom Sandbox After creating an account. [here](https://developer.safaricom.co.ke/),

![Test Image 1](./img/createapp.jpg)

#

## 2 Get your lipana mpesa pass keys and shortcode [here]()

![lipana mpesa pass keys and shortcode](./img/lnmpseapasskeynashortcode.jpg)

## Parameters in `lipanampesa()` method

```dart
lipanampesa()
//params imag

```

![lipana mpesa pass keys and shortcode](./img/requestparams.png)

## Response Params.

![lipana mpesa pass keys and shortcode](./img/responseparams.png)

In on pressed func, perform

```dart
MpesaService.lipanampesa(with all @requred params.).then((value) => funTogetValue(value))

```

```MpesaService.lipanampesa()``` Returns a promise, so you can tag a ```.then((withValue) => funToGetValues(value))``` to get the mpesa API response.
Safaricom API retuns 

```dart
{
  "MerchantRequestID":"20307-99562491-1"
  "CheckoutRequestID":"ws_CO_030920202354219695",
  "ResponseCode": "0",
  "ResponseDescription":"Success. Request accepted for processing",
  "CustomerMessage":"Success. Request accepted for processing"
}

```
As a response, so you can notify you client with ```CustomerMessage ``` as a success message.
And save the respons to database.
#

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
      print('MerchantRequestID = '+value['MerchantRequestID']),
      print('CheckoutRequestID = '+value['CheckoutRequestID']),
      print('ResponseCode = '+value['ResponseCode']),
      print('ResponseDescription = '+value['ResponseDescription']),
      print('CustomerMessage = '+value['CustomerMessage'])
    },
  )

```
