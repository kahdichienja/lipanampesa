import 'package:lipa_na_mpesa_online/lipa_na_mpesa_online.dart';
import 'package:lipa_na_mpesa_online/src/lnmonline/keys.dart' as key;
import 'package:lipa_na_mpesa_online/src/models/success_mpesa_initiation.dart';

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
    MpesaService.authenticate(
            key.apiCredintialURL_sand, key.consumer_key, key.consumer_secret)
        .then(
      (value) => print('Mpesa access_token: ' + value),
    ),
  );

  print(
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
      apiCredintialURL: key.apiCredintialURL_sand,
      apiurlforstkpush: key.apiurlforstkpush_prod,
    ).then(
      (InitialMpesaRespoce value) => {
        print('MerchantRequestID = ' + value.merchantRequestID),
        print('CheckoutRequestID = ' + value.checkoutRequestID),
        print('ResponseCode = ' + value.responseCode),
        print('ResponseDescription = ' + value.responseDescription),
        print('CustomerMessage = ' + value.customerMessage),
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
