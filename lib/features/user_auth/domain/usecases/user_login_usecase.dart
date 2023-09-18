import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/core/usecases/usecases.dart';
import 'package:shop/features/user_auth/domain/repositories/user_repo.dart';

import '../entities/user.dart';

class LoginUserUseCase implements UseCasesWithParams<User, LoginParams>{
  final UserRepo userRepo;
  const LoginUserUseCase({required this.userRepo});
  @override
  Future<Either<Failure, User>> call(LoginParams params) async{
    return await userRepo.loginUser(
        userEmail: params.userEmail,
        userPassword: params.userPassword);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class LoginParams extends Equatable{
  final String userEmail;
  final String userPassword;
  const LoginParams({required this.userPassword, required this.userEmail});

  @override
  List<Object> get props => [userEmail, userPassword];

}