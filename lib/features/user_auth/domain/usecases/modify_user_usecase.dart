import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/core/usecases/usecases.dart';
import 'package:shop/features/user_auth/domain/repositories/user_repo.dart';

class ModifyUserUseCase implements UseCasesWithParams<void, ModifyUserParams>{
  UserRepo userRepo;
  ModifyUserUseCase({required this.userRepo});

  @override
  Future<Either<Failure, void>> call(ModifyUserParams params) async{
    return await userRepo.modifyUserData(
        userID: params.userID,
        userName: params.userName,
        userSurname: params.userSurname,
        userEmail: params.userEmail,
        userPassword: params.userPassword,
        userMobilePhone: params.userMobilePhone,
        userCity: params.userCity,
        userPostalCode: params.userPostalCode,
        userAddress: params.userAddress);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class ModifyUserParams extends Equatable{
  final String userID;
  final String userName;
  final String userSurname;
  final String userEmail;
  final String userAddress;
  final String userPostalCode;
  final String userPassword;
  final String userMobilePhone;
  final String userCity;
  const ModifyUserParams({
    required this.userAddress,
    required this.userPostalCode,
    required this.userMobilePhone,
    required this.userEmail,
    required this.userSurname,
    required this.userName,
    required this.userPassword,
    required this.userCity,
    required this.userID,

});

  const ModifyUserParams.empty() : this(
    userEmail: 'userEmail',
    userPassword: 'userPassword',
    userName: 'userName',
    userSurname: 'userSurname',
    userAddress: 'userAddress',
    userMobilePhone: 'userMobilePhone',
    userPostalCode: 'userPostalCode',
    userCity: 'userCity',
    userID: "userID"
  );

  @override
  List<Object> get props => [userName, userSurname];
}