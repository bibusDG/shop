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
    required String userCountry,
    required String userPostalCode,
    required String userAddress,
    required bool isAdmin,
});

  Future<UserModel> loginUser({
    required String userPassword,
    required String userEmail,
});

  Future<void> deleteUser({
    required String userPassword,
    required String userEmail,
});

}

class UserFirebaseDataSourceImp implements UserFirebaseDataSource{
  @override
  Future<void> createUser({
    required String userID,
    required String userName,
    required String userSurname,
    required String userEmail,
    required String userPassword,
    required String userMobilePhone,
    required String userCountry,
    required String userPostalCode,
    required String userAddress,
    required bool isAdmin}) async{
      final addUser = await FirebaseFirestore.instance.collection('company').
      doc(COMPANY_NAME).collection('users').
      add(UserModel(
          userID: userID,
          userName: userName,
          userSurname: userSurname,
          userPassword: userPassword,
          userEmail: userEmail,
          userMobilePhone: userMobilePhone,
          isAdmin: isAdmin,
          userCountry: userCountry,
          userPostalCode: userPostalCode,
          userAddress: userAddress).toJson());
      final userDocID = addUser.id;
      await FirebaseFirestore.instance.collection('company').
      doc(COMPANY_NAME).
      collection('users').
      doc(userDocID).
      update({"userID": userDocID});

    // TODO: implement createUser
    // throw UnimplementedError();
  }

  @override
  Future<void> deleteUser({required String userPassword, required String userEmail}) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

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
  
}