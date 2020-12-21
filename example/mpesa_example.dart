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
    MpesaService.authenticate(key.apiCredintialURL_sand, key.consumer_key, key.consumer_secret).then(
      (value) => print('Mpesa access_token: ' + value),
    ),
  );


  print(
    MpesaService.lipanampesa(
      key.lipa_na_mpesa_passkey_prod,
      key.business_short_code_pod,
      key.consumer_key_prod,
      key.consumer_secret_prod,
      key.phone_number,
      key.transactiontype,
      key.amount,
      key.callbackURL_sand,
      key.accountref,
      key.transactionDesc,
      apiCredintialURL: key.apiCredintialURL_prod,
      apiurlforstkpush: key.apiurlforstkpush_prod
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
