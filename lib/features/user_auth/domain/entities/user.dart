import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String userID;
  final String userName;
  final String userSurname;
  final String userEmail;
  final String userPassword;
  final String userMobilePhone;
  final String userCountry;
  final String userPostalCode;
  final String userAddress;
  final bool isAdmin;

  const User({
    required this.userID,
    required this.userName,
    required this.userSurname,
    required this.userEmail,
    required this.userPassword,
    required this.userMobilePhone,
    required this.userCountry,
    required this.userAddress,
    required this.userPostalCode,
    required this.isAdmin,

});
  @override
  List<Object> get props => [userID, userEmail, userPassword, userName, userSurname];

}