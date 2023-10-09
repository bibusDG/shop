import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shop/core/fakes/fake_firebase_firestore.dart';
import 'package:shop/features/product_categories/data/models/product_category_model.dart';

void main() {

  group('FakeFirestoreService', () {

    FakeFirebaseFirestore? firestore;

    //my data which contains [UserModel.empty()]
    final Map<String, dynamic> data = const ProductCategoryModel.empty().toJson();

    //const values used for collection and docs name
    const String firstCollection = 'company_name';
    const String docName = 'fake_company';
    const String secondCollection = 'productCategory';

    setUp(() {
      firestore = FakeFirebaseFirestore();
    });

    group('CRUD operations on fake product category firebase', () {

      ///****************************

      test('should return [ProductCategory] data based on password an e-mail', () async {

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

      test('should get stream [ProductCategoryModel] data', () async{

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
        //stream data from fake firebase collection
        final stream = fakeFireStoreService.getSnapshotStreamFromCollection(
            collectionPath1: firstCollection,
            docName: docName,
            collectionPath2: secondCollection);

        //Assert
        stream.listen((event) {
          expect(data, equals(event.docs[0].data()));
        });
      });

      ///*************************

      test('should delete [ProductCategory.empty()] from data list', () async{

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
        where('productCategoryID', isEqualTo: 'productCategoryID').get().then((value) {
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

      test('should modify [ProductCategory.empty()] from data list', () async{

        //Arrange
        final fakeFireStoreService = FakeFireStoreService(firestore: firestore!);
        //add data to fake collection
        await fakeFireStoreService.addToCollection(
            data: data,
            collectionPath1: firstCollection,
            collectionPath2: secondCollection,
            docName: docName);

        //Act
        //get documentID to modify
        var idToModify = '';
        await firestore!.collection(firstCollection).doc(docName).collection(secondCollection).
        where('productCategoryID', isEqualTo: 'productCategoryID').get().then((value) {
          value.docs.forEach((element) {
            idToModify = element.id;
          });
        });

        //modify element from fake collection
        await fakeFireStoreService.setDataOnDocument(
          collectionPath1: firstCollection,
          docName: docName,
          collectionPath2: secondCollection,
          docID: idToModify,
          data: {'productCategoryName' : 'name', 'productCategoryPicture': 'picture'},
        );
        final modData = await firestore!.collection(firstCollection).doc(docName).collection(secondCollection).get();

        //Assert
        expect(modData.docs[0].data()['productCategoryName'], equals('name'));
      });

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
