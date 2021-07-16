import 'dart:convert';

class C2BInitialMpesaRespoce {
      String merchantRequestID;
      String checkoutRequestID;
      String responseCode;
      String responseDescription;
      String customerMessage;
  C2BInitialMpesaRespoce({
    required this.merchantRequestID,
    required this.checkoutRequestID,
    required this.responseCode,
    required this.responseDescription,
    required this.customerMessage,
  });


  C2BInitialMpesaRespoce copyWith({
    String? merchantRequestID,
    String? checkoutRequestID,
    String? responseCode,
    String? responseDescription,
    String? customerMessage,
  }) {
    return C2BInitialMpesaRespoce(
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

  factory C2BInitialMpesaRespoce.fromMap(Map<String, dynamic> map) {
    return C2BInitialMpesaRespoce(
      merchantRequestID: map['MerchantRequestID'],
      checkoutRequestID: map['CheckoutRequestID'],
      responseCode: map['ResponseCode'],
      responseDescription: map['ResponseDescription'],
      customerMessage: map['CustomerMessage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory C2BInitialMpesaRespoce.fromJson(String source) => C2BInitialMpesaRespoce.fromMap(json.decode(source));

  @override
  String toString() {
    return 'C2BInitialMpesaRespoce(merchantRequestID: $merchantRequestID, checkoutRequestID: $checkoutRequestID, responseCode: $responseCode, responseDescription: $responseDescription, customerMessage: $customerMessage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is C2BInitialMpesaRespoce &&
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
