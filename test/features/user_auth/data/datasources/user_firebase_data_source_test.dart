import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shop/core/fakes/fake_firebase_firestore.dart';
import 'package:shop/features/user_auth/data/models/user_model.dart';

void main() {

  group('FakeFirestoreService', () {

    FakeFirebaseFirestore? firestore;

    //my data which contains [UserModel.empty()]
    final Map<String, dynamic> data = const UserModel.empty().toJson();

    //const values used for collection and docs name
    const String firstCollection = 'company_name';
    const String docName = 'fake_company';
    const String secondCollection = 'users';

    setUp(() {
      firestore = FakeFirebaseFirestore();
    });

    group('CRUD operations on fake firebase', () {

      ///****************************

      test('should return [UserModel] data based on password an e-mail', () async {

        //Arrange
        final fakeFireStoreService = FakeFireStoreService(firestore: firestore!);
        //add element fo firebase collection
        await fakeFireStoreService.addToCollection(
            collectionPath1: firstCollection,
            docName: docName,
            collectionPath2: secondCollection,
            data: data,
           );

        //Act
        //get all documents from FakeFirebaseFirestore as list of elements
        final List<Map<String, dynamic>> actualData = (await firestore!.collection(firstCollection).
          doc(docName).
          collection(secondCollection).get()).docs.map((e) => e.data()).toList();


        //Assert
        //check if data received from fake database is equals to const data
        expect(data, equals(searchForElement(actualData, data)));
      });

      ///**********************

      test('shoud get fetched [UserModel] data', () async{

        //Arrange
        final fakeFireStoreService = FakeFireStoreService(firestore: firestore!);
        //add data do fake firebase collection
        await fakeFireStoreService.addToCollection(
          collectionPath1: firstCollection,
          docName: docName,
          collectionPath2: secondCollection,
          data: data,
        );

        //Act
        //fetch data from firebase collection
        final fetchedUser = await fakeFireStoreService.fetchData(
            collectionPath1: firstCollection,
            docName: docName,
            collectionPath2: secondCollection,
            userPassword: data['userPassword'],
            userEmail: data['userEmail']);

        //Assert
        //check if result is equal to saved to fake collection
        expect(data, equals(fetchedUser.docs[0].data()));
      });

      ///*************************

      test('should delete [UserModel.empty()] from data list', () async{

        //Arrange
        final fakeFireStoreService = FakeFireStoreService(firestore: firestore!);
        //add data to fake collection
        await fakeFireStoreService.addToCollection(
            data: data,
            collectionPath1: firstCollection,
            collectionPath2: secondCollection,
            docName: docName);

        //Act
        //get documentID to delete
        var idToDelete = '';
        await firestore!.collection(firstCollection).doc(docName).collection(secondCollection).
        where('userID', isEqualTo: 'id').get().then((value) {
          value.docs.forEach((element) {
            idToDelete = element.id;
          });
        });

        //delete element from fake collection
        await fakeFireStoreService.deleteDocumentFromCollection(
            collectionPath1: firstCollection,
            docName: docName,
            collectionPath2: secondCollection,
            docID: idToDelete,
        );
        final deletedData = await firestore!.collection(firstCollection).doc(docName).collection(secondCollection).get();

        //Assert
        //check if length of collection is equal to 0 after delete item
        expect(0, equals(deletedData.docs.length));
      });

      ///*******************************************

    });
  });
}

//Check if data found in FakeFirebaseFirestore list

searchForElement(listOfData, data){
  for (var element in listOfData){
    if (mapEquals(element, data)){
      return element;
    }
  }
}