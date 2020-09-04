import 'dart:convert';
import 'package:http/http.dart' as http;
class LNMOnline {
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
    String businessshortcode,
    String lipanampesapasskey,
  ) async {
    try {
      var formarttime = await formateDateToYMDHMS();
      print(formarttime);
      String _rawPassword =
          businessshortcode + lipanampesapasskey + formarttime;

      List<int> passwordBytes = utf8.encode(_rawPassword);

      String password = base64.encode(passwordBytes);
      print(password);
      return password;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // getting access token from mpesa sandbox.
  Future<String> authenticate(String consumerkey, String consumersecret) async {
    var _accessToken =
        base64Url.encode((consumerkey + ":" + consumersecret).codeUnits);
    try {
      http.Response response = await http.get(
        apiCredintialURL,
        headers: {
          "Authorization": "Basic $_accessToken",
        },
      );
      var data = json.decode(response.body);
      print(data);
      return data["access_token"];
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void c2blipanampesaonlinestkpush(
    var password,
    var accesstoken,
    String callbackURL,
    String businessshortcode,
    String transactiontype,
    String partyAphonenumber,
    String phoneNumber,
    String accountReference,
    String transactionDesc,
  ) async {
    var formartedtime = await formateDateToYMDHMS();
    // var password = await generatepassword();
    // var accesstoken = await authenticate();

    String requestbody = json.encode({
      'BusinessShortCode': businessshortcode,
      'Password': password,
      'Timestamp': formartedtime,
      'TransactionType': transactiontype, //CustomerPayBillOnline
      'Amount': 1,
      'PartyA': partyAphonenumber,
      'PartyB': businessshortcode,
      'PhoneNumber': phoneNumber,
      'CallBackURL': callbackURL,
      'AccountReference': accountReference,
      'TransactionDesc': transactionDesc,
    });
    try {
      http.Response response = await http.post(
        apiurlforstkpush,
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
  }
}
