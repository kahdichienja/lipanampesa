import 'package:lipa_na_mpesa_online/lipa_na_mpesa_online.dart';
import 'package:lipa_na_mpesa_online/src/lnmonline/keys.dart' as key;

void main() {
var lnmpsatest = LNMOnline();
     var formatedate = lnmpsatest.formateDateToYMDHMS();
     var password = lnmpsatest.generatepassword(key.business_short_code, key.lipa_na_mpesa_passkey);
     var accesstoken = lnmpsatest.authenticate(key.consumer_key, key.consumer_secret);
     var pay = lnmpsatest.c2blipanampesaonlinestkpush(password, accesstoken, key.callbackURL, key.business_short_code, key.transactiontype, key.phone_number, key.phone_number, key.accountref, key.transactionDesc);

     print('Password: $password');
     print('Access Token: $accesstoken');
    //  print(pay);
}