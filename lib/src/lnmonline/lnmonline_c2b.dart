import 'dart:convert';
import 'package:http/http.dart' as http;

class MpesaTransactionResponse {
  String customerMessage;
  String merchantRequestID;
  String responseCode;
  String checkoutRequestID;
  String responseDescription;
  String message;
  MpesaTransactionResponse({
    this.merchantRequestID,
    this.checkoutRequestID,
    this.responseDescription,
    this.customerMessage,
    this.responseCode,
    this.message,
  });
}

class MpesaTransactionResponseToken {
  String accesstoken;
  MpesaTransactionResponseToken({this.accesstoken});
}

class MpesaService {
 

  static Future<dynamic> formateDateToYMDHMS() async {
    try {
      var now = DateTime.now();
      var formartedtime =
          "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}";
      return formartedtime;
    } catch (e) {
      return new MpesaTransactionResponse(customerMessage: e.toString());
    }
  }

  static Future<dynamic> generatepassword(
      var lipanampesapasskey, var businessshortcode) async {
    try {
      var formartedtime = await MpesaService.formateDateToYMDHMS();
      String _rawPassword =
          businessshortcode + lipanampesapasskey + formartedtime;
      List<int> passwordBytes = utf8.encode(_rawPassword);
      String password = base64.encode(passwordBytes);
      return password;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<dynamic> authenticate(
      var apiCredintialURL, var consumerkey, var consumersecret) async {
    var _accessToken = base64Url.encode((consumerkey + ":" + consumersecret).codeUnits);
    var apiURL = apiCredintialURL;
    try {
      http.Response response = await http
          .get(apiURL, headers: {"Authorization": "Basic $_accessToken"});
      var data = json.decode(response.body);
      return data["access_token"];
    } catch (e) {
      return new MpesaTransactionResponseToken(
          accesstoken:
              'Invalid ConsumerKey: $consumerkey or ConsumerSecrete: $consumersecret');
    }
  }

  static Future<dynamic> lipanampesa(
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
      {var apiCredintialURL,
      var apiurlforstkpush}) async {
    var accesstoken = await MpesaService.authenticate(apiCredintialURL, consumerkey, consumersecret);
    var formartedtime = await MpesaService.formateDateToYMDHMS();
    var _password = await MpesaService.generatepassword(lipanampesapasskey, businessshortcode);

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
        apiurlforstkpush,
        body: requestbody,
        headers: {
          'Authorization': 'Bearer $accesstoken',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw json.decode(response.body);
        // return json.decode(response.body);
      }
    } catch (e) {
      print(e);
      return new MpesaTransactionResponse(customerMessage: "Invalid details");
    }
  }

  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.responseCode != 0) {
      message = 'Transaction cancelled';
    }
    return new MpesaTransactionResponse(customerMessage: message);
  }
}
