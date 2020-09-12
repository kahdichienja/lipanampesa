import 'package:lipa_na_mpesa_online/lipa_na_mpesa_online.dart';
import 'package:lipa_na_mpesa_online/src/lnmonline/keys.dart' as key;

void main() {
  print(
    MpesaService.formateDateToYMDHMS().then(
      (value) => print('Date: ' + value),
    ),
  );
  print(
    MpesaService.generatepassword(
            key.lipa_na_mpesa_passkey, key.business_short_code)
        .then(
      (value) => print('Password: ' + value),
    ),
  );
  print(
    MpesaService.authenticate(key.consumer_key, key.consumer_secret).then(
      (value) => print('Mpesa access_token: ' + value),
    ),
  );
  print(
    MpesaService.authenticate(key.consumer_key, key.consumer_secret).then(
      (value) => print('Mpesa access_token: ' + value),
    ),
  );

  print(
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
    ).then(
      (value) => {
        print('MerchantRequestID = ' + value['MerchantRequestID']),
        print('CheckoutRequestID = ' + value['CheckoutRequestID']),
        print('ResponseCode = ' + value['ResponseCode']),
        print('ResponseDescription = ' + value['ResponseDescription']),
        print('CustomerMessage = ' + value['CustomerMessage']),
      },
    ),
  );
}

// {
//   "MerchantRequestID":"20307-99562491-1"
// "CheckoutRequestID":"ws_CO_030920202354219695",
// "ResponseCode": "0",
// "ResponseDescription":"Success. Request accepted for processing",
// "CustomerMessage":"Success. Request accepted for processing"
// }
