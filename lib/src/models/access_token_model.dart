import 'dart:convert';

class C2BAccessTokenModel {
  String accessToken;
  String expiresIn;
  C2BAccessTokenModel({
    required this.accessToken,
    required this.expiresIn,
  });




  C2BAccessTokenModel copyWith({
    String? accessToken,
    String? expiresIn,
  }) {
    return C2BAccessTokenModel(
      accessToken: accessToken ?? this.accessToken,
      expiresIn: expiresIn ?? this.expiresIn,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'access_token': accessToken,
      'expires_in': expiresIn,
    };
  }

  factory C2BAccessTokenModel.fromMap(Map<String, dynamic> map) {
    return C2BAccessTokenModel(
      accessToken: map['access_token'],
      expiresIn: map['expires_in'],
    );
  }

  String toJson() => json.encode(toMap());

  factory C2BAccessTokenModel.fromJson(String source) => C2BAccessTokenModel.fromMap(json.decode(source));

  @override
  String toString() => 'C2BAccessTokenModel(accessToken: $accessToken, expiresIn: $expiresIn)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is C2BAccessTokenModel &&
      other.accessToken == accessToken &&
      other.expiresIn == expiresIn;
  }

  @override
  int get hashCode => accessToken.hashCode ^ expiresIn.hashCode;
}
