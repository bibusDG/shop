import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/core/usecases/usecases.dart';

import '../repositories/user_repo.dart';

class ModifyUserValueUseCase implements UseCasesWithParams <void, UserValueParams> {
  UserRepo userRepo;
  ModifyUserValueUseCase({required this.userRepo});


  @override
  Future<Either<Failure, void>> call(params) async{
    return await userRepo.modifyUserValue(
        userID: params.userID,
        value: params.value,
        valueID: params.valueID,
    );
    // TODO: implement call
    throw UnimplementedError();
  }}

class UserValueParams extends Equatable{
  final String userID;
  final dynamic value;
  final String valueID;
  const UserValueParams({
    required this.userID,
    required this.value,
    required this.valueID
});
  @override
  List<Object> get props => [userID, value, valueID];
}