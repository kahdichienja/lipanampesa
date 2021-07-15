import 'dart:convert';

class InitialMpesaRespoce {
      String merchantRequestID;
      String checkoutRequestID;
      String responseCode;
      String responseDescription;
      String customerMessage;
  InitialMpesaRespoce({
    required this.merchantRequestID,
    required this.checkoutRequestID,
    required this.responseCode,
    required this.responseDescription,
    required this.customerMessage,
  });


  InitialMpesaRespoce copyWith({
    String? merchantRequestID,
    String? checkoutRequestID,
    String? responseCode,
    String? responseDescription,
    String? customerMessage,
  }) {
    return InitialMpesaRespoce(
      merchantRequestID: merchantRequestID ?? this.merchantRequestID,
      checkoutRequestID: checkoutRequestID ?? this.checkoutRequestID,
      responseCode: responseCode ?? this.responseCode,
      responseDescription: responseDescription ?? this.responseDescription,
      customerMessage: customerMessage ?? this.customerMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'MerchantRequestID': merchantRequestID,
      'CheckoutRequestID': checkoutRequestID,
      'ResponseCode': responseCode,
      'ResponseDescription': responseDescription,
      'CustomerMessage': customerMessage,
    };
  }

  factory InitialMpesaRespoce.fromMap(Map<String, dynamic> map) {
    return InitialMpesaRespoce(
      merchantRequestID: map['MerchantRequestID'],
      checkoutRequestID: map['CheckoutRequestID'],
      responseCode: map['ResponseCode'],
      responseDescription: map['ResponseDescription'],
      customerMessage: map['CustomerMessage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InitialMpesaRespoce.fromJson(String source) => InitialMpesaRespoce.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InitialMpesaRespoce(merchantRequestID: $merchantRequestID, checkoutRequestID: $checkoutRequestID, responseCode: $responseCode, responseDescription: $responseDescription, customerMessage: $customerMessage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is InitialMpesaRespoce &&
      other.merchantRequestID == merchantRequestID &&
      other.checkoutRequestID == checkoutRequestID &&
      other.responseCode == responseCode &&
      other.responseDescription == responseDescription &&
      other.customerMessage == customerMessage;
  }

  @override
  int get hashCode {
    return merchantRequestID.hashCode ^
      checkoutRequestID.hashCode ^
      responseCode.hashCode ^
      responseDescription.hashCode ^
      customerMessage.hashCode;
  }
}
