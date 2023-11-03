import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/core/usecases/usecases.dart';

import '../repositories/user_repo.dart';

class ModifyUserVoucherValueUseCase implements UseCasesWithParams <void, UserVoucherParams> {
  UserRepo userRepo;
  ModifyUserVoucherValueUseCase({required this.userRepo});


  @override
  Future<Either<Failure, void>> call(params) async{
    print('usecase OK');
    return await userRepo.modifyUserVoucherValue(
        userID: params.userID,
        voucherValue: params.voucherValue);
    // TODO: implement call
    throw UnimplementedError();
  }}

class UserVoucherParams extends Equatable{
  final String userID;
  final double voucherValue;
  const UserVoucherParams({
    required this.userID,
    required this.voucherValue,
});
  @override
  List<Object> get props => [userID, voucherValue];
}