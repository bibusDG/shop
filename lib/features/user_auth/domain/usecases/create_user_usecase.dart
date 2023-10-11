import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/core/usecases/usecases.dart';
import 'package:shop/features/user_auth/domain/repositories/user_repo.dart';

class CreateUserUseCase implements UseCasesWithParams<void, CreateUserParams>{
  final UserRepo userRepo;
  const CreateUserUseCase({required this.userRepo});

  @override
  Future<Either<Failure, void>> call(CreateUserParams params) async{
    return await userRepo.createNewUser(
        userID: params.userID,
        userName: params.userName,
        userSurname: params.userSurname,
        userEmail: params.userEmail,
        userPassword: params.userPassword,
        userMobilePhone: params.userMobilePhone,
        userCity: params.userCity,
        userPostalCode: params.userPostalCode,
        userAddress: params.userAddress,
        userBonusPoints: params.userBonusPoints,
        isAdmin: params.isAdmin);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class CreateUserParams extends Equatable{
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
  final int userBonusPoints;

  const CreateUserParams.empty() : this(
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
    userBonusPoints: 0,
  );

  const CreateUserParams({
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
    required this.userBonusPoints,

  });
  @override
  List<Object> get props => [userID, userEmail, userPassword, userName, userSurname];
}