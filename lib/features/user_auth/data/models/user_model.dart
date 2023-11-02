import 'dart:convert';

import 'package:shop/features/user_auth/domain/entities/user.dart';

class UserModel extends User{
  const UserModel({
    required super.userID,
    required super.userName,
    required super.userSurname,
    required super.userPassword,
    required super.userEmail,
    required super.userMobilePhone,
    required super.isAdmin,
    required super.userCity,
    required super.userPostalCode,
    required super.userAddress,
    required super.userBonusPoints,
    required super.voucherValue,
});
  const UserModel.empty() : this(
    userPassword: 'password',
    userEmail: 'email',
    userPostalCode: 'postalCode',
    userMobilePhone: 'phone',
    userCity: 'city',
    userAddress: 'address',
    userSurname: 'surname',
    userName: 'name',
    userID: 'id',
    isAdmin: false,
    userBonusPoints: 0,
    voucherValue: 0.0,
  );

  UserModel copyWith({
    String? userID,
    String? userName,
    String? userSurname,
    String? userEmail,
    String? userPassword,
    String? userMobilePhone,
    String? userCity,
    String? userPostalCode,
    String? userAddress,
    bool? isAdmin,
    int? userBonusPoints,
    double? voucherValue,
  }) =>
      UserModel(
        userID: userID ?? this.userID,
        userName: userName ?? this.userName,
        userSurname: userSurname ?? this.userSurname,
        userEmail: userEmail ?? this.userEmail,
        userPassword: userPassword ?? this.userPassword,
        userMobilePhone: userMobilePhone ?? this.userMobilePhone,
        userCity: userCity ?? this.userCity,
        userPostalCode: userPostalCode ?? this.userPostalCode,
        userAddress: userAddress ?? this.userAddress,
        isAdmin: isAdmin ?? this.isAdmin,
        userBonusPoints: userBonusPoints ?? this.userBonusPoints,
        voucherValue: voucherValue ?? this.voucherValue,
      );

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userID: json["userID"],
    userName: json["userName"],
    userSurname: json["userSurname"],
    userEmail: json["userEmail"],
    userPassword: json["userPassword"],
    userMobilePhone: json["userMobilePhone"],
    userCity: json["userCity"],
    userPostalCode: json["userPostalCode"],
    userAddress: json["userAddress"],
    isAdmin: json["isAdmin"],
    userBonusPoints: json["userBonusPoints"],
    voucherValue: json["voucherValue"],
  );

  Map<String, dynamic> toJson() => {
    "userID": userID,
    "userName": userName,
    "userSurname": userSurname,
    "userEmail": userEmail,
    "userPassword": userPassword,
    "userMobilePhone": userMobilePhone,
    "userCity": userCity,
    "userPostalCode": userPostalCode,
    "userAddress": userAddress,
    "isAdmin": isAdmin,
    "userBonusPoints": userBonusPoints,
    "voucherValue": voucherValue,
  };

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userID: map['userID'] as String,
      userName: map['userName'] as String,
      userSurname: map['userSurname'] as String,
      userEmail: map['userEmail'] as String,
      userPassword: map['userPassword'] as String,
      userMobilePhone: map['userMobilePhone'] as String,
      userCity: map['userCity'] as String,
      userPostalCode: map['userPostalCode'] as String,
      userAddress: map['userAddress'] as String,
      isAdmin: map['isAdmin'] as bool,
      userBonusPoints: map['userBonusPoints'] as int,
      voucherValue: map['voucherValue'] as double
    );
  }

}