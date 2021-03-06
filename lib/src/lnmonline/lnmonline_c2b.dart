import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lipa_na_mpesa_online/src/models/access_token_model.dart';
import 'package:lipa_na_mpesa_online/src/models/success_mpesa_initiation.dart';

class MpesaTransactionResponse {
  String? customerMessage;
  String? merchantRequestID;
  String? responseCode;
  String? checkoutRequestID;
  String? responseDescription;
  String? message;
  MpesaTransactionResponse({
    this.merchantRequestID,
    this.checkoutRequestID,
    this.responseDescription,
    this.customerMessage,
    this.responseCode,
    this.message,
  });
}

class MpesaService {
  static const String grantCredentilaUrlSandBox =  "https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials";
  static const String grantCredentilaUrlProduction =  "https://api.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials";
  static const String resourceUrlSandBox = "https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest";
  static const String resourceUrlProduction = "https://api.safaricom.co.ke/mpesa/stkpush/v1/processrequest";

  /// This is the form that Daraja API require for generating pwd.
  ///

  static Future<String> formateDateToYMDHMS() async {
    try {
      DateTime now = DateTime.now();
      String formartedtime =
          "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}";
      return formartedtime;
    } catch (e) {
      return catchAPIErrorMessage(message: e.toString());
    }
  }

  ///
  ///To make an API call, you will need to authenticate your app.
  ///safaricom have provided an OAuth API for you to generate an access token,
  /// safaricom support client_credentials grant type.
  /// To authorize your API call to the OAuth API,
  ///  you will need a Basic Auth over HTTPS authorization token.
  ///  The Basic Auth string is a base64 encoded string of your app’s client key
  /// and client secret. safaricom have provided a means to obtain the Basic Auth string for
  ///  your sandbox apps or production; while you are in the OAuth API’s sandbox.
  /// Click on ‘HTTP Basic Set Credentials’ button.
  /// ```dart
  /// generatepassword(lipanampesapasskey, businessshortcode)
  /// ```
  /// the function above do the magic. using the
  /// ```dart
  /// formateDateToYMDHMS()
  /// ```
  ///  FROM SAFARICOM API.
  /// The OAuth access token expires after an hour, after which,
  ///  you will need to generate another access token.
  /// On a production app, use a base64 library of the programming
  /// language you are using to build your app to get the Basic Auth
  ///  string that you will then use to invoke our OAuth API to get an access token.

  static Future<String> generatepassword(
      String lipanampesapasskey, String businessshortcode) async {
    try {
      String formartedtime = await MpesaService.formateDateToYMDHMS();

      String _rawPassword =
          businessshortcode + lipanampesapasskey + formartedtime;

      List<int> passwordBytes = utf8.encode(_rawPassword);

      String password = base64.encode(passwordBytes);

      return password;
    } catch (e) {
      return e.toString();
    }
  }

  /// ALL THIS IS IN SAFARICOM DOCS.
  /// HTTP Header Parameters
  /// With an OAuth 2.0 Access Token, an application can
  /// now invoke our APIs by including the access token in
  /// the HTTP header. Our APIs currently only supports application/json content type.
  ///
  /// M-Pesa Core authenticates a transaction by decrypting the security credentials.
  ///  Security credentials are generated by encrypting the base64 encoded initiator
  ///  password with M-Pesa’s public key, a X509 certificate.

  /// The algorithm for generating security credentials is as follows:

  /// Write the unencrypted password into a byte array.

  /// Encrypt the array with the M-Pesa public key certificate.
  /// Use the RSA algorithm, and use PKCS #1.5 padding (not OAEP),
  ///  and add the result to the encrypted stream.

  /// Convert the resulting encrypted byte array into a string
  /// using base64 encoding. The resulting base64 encoded string is the security credential.

  static Future<String> authenticate(
      {
      required String consumerkey,
      required String consumersecret,
      required bool isProduction,
      }) async {
    String _accessToken =
        base64Url.encode((consumerkey + ":" + consumersecret).codeUnits);

    try {
      http.Response response = await http.get(Uri.parse(isProduction ? grantCredentilaUrlProduction : grantCredentilaUrlSandBox),
          headers: {"Authorization": "Basic $_accessToken"});

      Map<String, dynamic> map = json.decode(response.body);

      return C2BAccessTokenModel.fromMap(map).accessToken;
    } catch (e) {
      return catchAPIErrorMessage(
          message:
              'Invalid ConsumerKey: $consumerkey or ConsumerSecrete: $consumersecret :' +
                  e.toString());
    }
  }

  /// Lipa na M-Pesa Online Payment API is used to initiate
  /// a M-Pesa transaction on behalf of a customer using STK Push.
  /// This is the same technique mySafaricom App uses whenever the
  ///  app is used to make payments.
  /// String lipanampesapasskey,
  /// String businessshortcode,
  /// String consumerkey,
  /// String consumersecret,
  /// String phonenumber,
  /// String transactionType,
  /// String amount,
  /// String callBackURL,
  /// String accountReference,
  /// String transactionDesc,
  ///{required String apiCredintialURL,
  ///   required String apiurlforstkpush}

  static Future<C2BInitialMpesaRespoce> lipanampesa({
    required String lipanampesapasskey,
    required String businessshortcode,
    required String consumerkey,
    required String consumersecret,
    required String phonenumber,
    required String transactionType,
    required String amount,
    required String callBackURL,
    required String accountReference,
    required String transactionDesc,
    required bool isProduction,
  }) async {
    String accesstoken = await MpesaService.authenticate(consumerkey: consumerkey, consumersecret: consumersecret, isProduction: isProduction);
    String formartedtime = await MpesaService.formateDateToYMDHMS();
    String _password = await MpesaService.generatepassword(
        lipanampesapasskey, businessshortcode);

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
    // try {
    http.Response response = await http.post(
      Uri.parse(isProduction? resourceUrlProduction: resourceUrlSandBox),
      body: requestbody,
      headers: {
        'Authorization': 'Bearer $accesstoken',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      // C2BInitialMpesaRespoce
      return C2BInitialMpesaRespoce.fromMap(map);
    } else {
      throw json.decode(response.body);
    }
    // } catch (e) {
    // return catchAPIError(message: {"message":"Invalid details: ${e.toString()}"});
    // }
  }

  static String catchAPIErrorMessage({required String message}) => message;
  static Map<String, dynamic> catchAPIError(
          {required Map<String, dynamic> message}) =>
      message;
}
