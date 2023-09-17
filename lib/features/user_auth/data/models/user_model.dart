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
    required super.userCountry,
    required super.userPostalCode,
    required super.userAddress
});
  UserModel copyWith({
    String? userID,
    String? userName,
    String? userSurname,
    String? userEmail,
    String? userPassword,
    String? userMobilePhone,
    String? userCountry,
    String? userPostalCode,
    String? userAddress,
    bool? isAdmin,
  }) =>
      UserModel(
        userID: userID ?? this.userID,
        userName: userName ?? this.userName,
        userSurname: userSurname ?? this.userSurname,
        userEmail: userEmail ?? this.userEmail,
        userPassword: userPassword ?? this.userPassword,
        userMobilePhone: userMobilePhone ?? this.userMobilePhone,
        userCountry: userCountry ?? this.userCountry,
        userPostalCode: userPostalCode ?? this.userPostalCode,
        userAddress: userAddress ?? this.userAddress,
        isAdmin: isAdmin ?? this.isAdmin,
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
    userCountry: json["userCountry"],
    userPostalCode: json["userPostalCode"],
    userAddress: json["userAddress"],
    isAdmin: json["isAdmin"],
  );

  Map<String, dynamic> toJson() => {
    "userID": userID,
    "userName": userName,
    "userSurname": userSurname,
    "userEmail": userEmail,
    "userPassword": userPassword,
    "userMobilePhone": userMobilePhone,
    "userCountry": userCountry,
    "userPostalCode": userPostalCode,
    "userAddress": userAddress,
    "isAdmin": isAdmin,
  };
}