import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String userID;
  final String userName;
  final String userSurname;
  final String userEmail;
  final String userPassword;
  final String userMobilePhone;
  final String userCity;
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
    required this.userCity,
    required this.userAddress,
    required this.userPostalCode,
    required this.isAdmin,
});

  const User.empty() : this(
    userID: 'empty_userID',
    userName: 'empty_userName',
    userSurname: 'empty_userSurname',
    userPassword: 'empty_userPassword',
    userAddress: 'empty_usrAddress',
    userCity: 'empty_userCity',
    userEmail: 'empty_userEmail',
    userMobilePhone: 'empty_userMobilePhone',
    userPostalCode: 'empty_userPostalCode',
    isAdmin: false,
  );

  @override
  List<Object> get props => [userID, userEmail, userPassword, userName, userSurname];

}