import 'package:dartz/dartz.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/core/usecases/usecases.dart';
import 'package:shop/features/user_auth/domain/repositories/user_repo.dart';

class LogOutUserUseCase implements UseCaseWithoutParams<void>{
  final UserRepo userRepo;
  LogOutUserUseCase({required this.userRepo});
  @override
  Future<Either<Failure, dynamic>> call() async{
    return await userRepo.logOutUser();
    // TODO: implement call
    throw UnimplementedError();
  }

}