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
        userCountry: params.userCountry,
        userPostalCode: params.userPostalCode,
        userAddress: params.userAddress,
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
  final String userCountry;
  final String userPostalCode;
  final String userAddress;
  final bool isAdmin;

  const CreateUserParams({
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