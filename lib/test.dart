/*import 'dart:convert';
import 'package:http/http.dart' as http;

var apiCredintialURL =
    "https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials";
var apiurlforstkpush =
    "https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest";

Future<dynamic> formateDateToYMDHMS() async {
  try {
    var now = DateTime.now();
    var formartedtime =
        "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}";
    return formartedtime;
  } catch (e) {
    print(e);
  }
}

Future<String> generatepassword(
    var lipanampesapasskey, var businessshortcode) async {
  try {
    var formartedtime = await formateDateToYMDHMS();
    print(formartedtime);
    String _rawPassword =
        businessshortcode + lipanampesapasskey + formartedtime;

    List<int> passwordBytes = utf8.encode(_rawPassword);

    String password = base64.encode(passwordBytes);
    return password;
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<String> authenticate(var consumerkey, var consumersecret) async {
  var _accessToken =
      base64Url.encode((consumerkey + ":" + consumersecret).codeUnits);
  var apiURL =
      "https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials";
  try {
    http.Response response = await http.get(
      apiURL,
      headers: {
        "Authorization": "Basic $_accessToken",
      },
    );
    var data = json.decode(response.body);
    print('AccessToken: $data');
    return data["access_token"];
  } catch (e) {
    print(e);
    rethrow;
  }
}

lipanampesa(
  var lipanampesapasskey,
  var businessshortcode,
  var consumerkey,
  var consumersecret,
  var phonenumber,
  var transactionType,
  var amount,
  var callBackURL,
  var accountReference,
  var transactionDesc,
) async {
  var apiurl =
      "https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest";

  var formartedtime = await formateDateToYMDHMS();
  var _password = await generatepassword(lipanampesapasskey, businessshortcode);
  var accesstoken = await authenticate(consumerkey, consumersecret);

  String requestbody = json.encode({
    'BusinessShortCode': businessshortcode,
    'Password': _password,
    'Timestamp': formartedtime,
    'TransactionType': transactionType, //CustomerPayBillOnline
    'Amount': amount,
    'PartyA': phonenumber,
    'PartyB': businessshortcode,
    'PhoneNumber': phonenumber,
    'CallBackURL': callBackURL,
    'AccountReference': accountReference,
    'TransactionDesc': transactionDesc
  });
  try {
    http.Response response = await http.post(
      apiurl,
      body: requestbody,
      headers: {
        'Authorization': 'Bearer $accesstoken',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      // {
      //   "MerchantRequestID":"20307-99562491-1"
      // "CheckoutRequestID":"ws_CO_030920202354219695",
      // "ResponseCode": "0",
      // "ResponseDescription":"Success. Request accepted for processing",
      // "CustomerMessage":"Success. Request accepted for processing"
      // }
      print(json.decode(response.body));
      var resObj = await json.decode(response.body);
      print(resObj.MerchantRequestID);
      print(resObj.CheckoutRequestID);
      print(resObj.ResponseCode);
      print(resObj.ResponseDescription);
      print(resObj.CustomerMessage);

      return json.decode(response.body);
    } else {
      throw json.decode(response.body);
    }
  } catch (e) {
    print(e);
  }
}*/