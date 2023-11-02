// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:shop/core/failures/failure.dart';
// import 'package:shop/core/usecases/usecases.dart';
//
// import '../repositories/user_repo.dart';
//
// class ModifyUserVoucherValueUseCase implements UseCasesWithParams <void, UserVoucherParams> {
//   UserRepo userRepo;
//   ModifyUserVoucherValueUseCase({required this.userRepo});
//
//
//   @override
//   Future<Either<Failure, void>> call(params) async{
//     return await userRepo.modifyUserVoucherValue(
//         userEmail: params.userEmail,
//         userMobilePhone: params.userMobilePhone,
//         voucherValue: params.voucherValue);
//     // TODO: implement call
//     throw UnimplementedError();
//   }}
//
// class UserVoucherParams extends Equatable{
//   final String userEmail;
//   final String userMobilePhone;
//   final double voucherValue;
//   const UserVoucherParams({
//     required this.voucherValue,
//     required this.userMobilePhone,
//     required this.userEmail,
// });
//   @override
//   List<Object> get props => [userEmail, userMobilePhone, voucherValue];
// }