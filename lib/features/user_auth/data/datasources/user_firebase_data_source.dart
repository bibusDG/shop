import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/core/constants/constants.dart';

import '../models/user_model.dart';

abstract class UserFirebaseDataSource{
  const UserFirebaseDataSource();

  Future<void> createUser({
    required String userID,
    required String userName,
    required String userSurname,
    required String userEmail,
    required String userPassword,
    required String userMobilePhone,
    required String userCity,
    required String userPostalCode,
    required String userAddress,
    required bool isAdmin,
    required int userBonusPoints,
    required double voucherValue,
    required int productsForFree,
});

  Future<UserModel> loginUser({
    required String userPassword,
    required String userEmail,
});

  Future<void> deleteUser({
    required String userID,
    required String userPassword,
    required String userEmail,
});

  Future<void> modifyUser({
    required String userID,
    required String userName,
    required String userSurname,
    required String userEmail,
    required String userPassword,
    required String userMobilePhone,
    required String userCity,
    required String userPostalCode,
    required String userAddress,
    required double voucherValue,
    required int productsForFree,
});
  
  Future<void> modifyUserValue({
    required String userID,
    required dynamic value,
    required String valueID,
});

}


///firebase code for creating new user

class UserFirebaseDataSourceImp implements UserFirebaseDataSource{
  @override
  Future<void> createUser({
    required String userID,
    required String userName,
    required String userSurname,
    required String userEmail,
    required String userPassword,
    required String userMobilePhone,
    required String userCity,
    required String userPostalCode,
    required String userAddress,
    required bool isAdmin,
    required double voucherValue,
    required int userBonusPoints,
    required int productsForFree,
  }) async{
      final addUser = await FirebaseFirestore.instance.collection('company').
      doc(COMPANY_NAME).collection('users').
      add(UserModel(
          voucherValue: voucherValue,
          userID: userID,
          userName: userName,
          userSurname: userSurname,
          userPassword: userPassword,
          userEmail: userEmail,
          userMobilePhone: userMobilePhone,
          isAdmin: isAdmin,
          userCity: userCity,
          userPostalCode: userPostalCode,
          userBonusPoints: userBonusPoints,
          userAddress: userAddress,
          productsForFree: productsForFree
      ).toJson());
      final userDocID = addUser.id;
      await FirebaseFirestore.instance.collection('company').
      doc(COMPANY_NAME).
      collection('users').
      doc(userDocID).
      update({"userID": userDocID});

    // TODO: implement createUser
    // throw UnimplementedError();
  }


  ///delete user from firebase

  @override
  Future<void> deleteUser({
    required String userID,
    required String userPassword,
    required String userEmail}) async{
    await FirebaseFirestore.instance.collection('company').
      doc(COMPANY_NAME).
      collection('users').
      doc(userID).delete();
    // TODO: implement deleteUser
    // throw UnimplementedError();
  }

  ///get user data from firebase

  @override
  Future<UserModel> loginUser({
    required String userPassword,
    required String userEmail}) async{
    final userData = await FirebaseFirestore.instance.collection('company').
        doc(COMPANY_NAME).
        collection('users').
        where("userEmail", isEqualTo: userEmail).
        where("userPassword", isEqualTo: userPassword).get();
    UserModel user = UserModel.fromJson(Map<String, dynamic>.from(userData.docs[0].data()));
    return user;
    // TODO: implement loginUser
    throw UnimplementedError();
  }

  @override
  Future<void> modifyUser({
    required double voucherValue,
    required String userID,
    required String userName,
    required String userSurname,
    required String userEmail,
    required String userPassword,
    required String userMobilePhone,
    required String userCity,
    required String userPostalCode,
    required String userAddress,
    required int productsForFree,
  }) async{
    await FirebaseFirestore.instance.
    collection('company').
    doc(COMPANY_NAME).
    collection('users').
    doc(userID).
    update(
      {
        "userName": userName,
        "userSurname": userSurname,
        "userEmail": userEmail,
        "userMobilePhone": userMobilePhone,
        "userCity": userCity,
        "userPostalCode": userPostalCode,
        "userAddress": userAddress,
        "userPassword": userPassword,
        "voucherValue": voucherValue,
        "productsForFree": productsForFree,
      }
    );
    // TODO: implement modifyUser
    // throw UnimplementedError();
  }

  @override
  Future<void> modifyUserValue({
    required String userID,
    required dynamic value,
    required String valueID,
  }) async{
    final user = await FirebaseFirestore.instance.collection('company').
    doc(COMPANY_NAME).collection('users').doc(userID).get();
    await FirebaseFirestore.instance.collection('company').
    doc(COMPANY_NAME).
    collection('users').doc(userID).
    update(valueID == 'voucherValue'? {valueID : user.data()?[valueID] + value} : {valueID : value});
    // TODO: implement modifyUserVoucherValue
    // throw UnimplementedError();
  }
  
}
