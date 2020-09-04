import 'package:lipa_na_mpesa_online/lipa_na_mpesa_online.dart';
import 'package:lipa_na_mpesa_online/src/lnmonline/keys.dart' as key;

void main() {
var pay = lipanampesa(key.lipa_na_mpesa_passkey, key.business_short_code, key.consumer_key, key.consumer_secret, key.phone_number, key.transactiontype, key.amount, key.callbackURL, key.accountref, key.transactionDesc);
print(pay);
}