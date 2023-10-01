import 'package:cloud_firestore/cloud_firestore.dart';

class FakeFireStoreService {
  const FakeFireStoreService({required this.firestore});

  final FirebaseFirestore firestore;

  /// Collection Operations

  Future<DocumentReference<Map<String, dynamic>>> addToCollection(
      {required Map<String, dynamic> data,
        required String collectionPath1,
        required String collectionPath2,
        required String docName,
      }) async {
    return firestore.collection(collectionPath1).doc(docName).collection(collectionPath2).add(data);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchData(
      {required String collectionPath1,
        required String docName,
        required String collectionPath2,
        required String userPassword,
        required String userEmail,
      }) {
    return firestore.collection(collectionPath1).
        doc(docName).
        collection(collectionPath2).
        where('userPassword', isEqualTo:  userPassword).
        where('userEmail', isEqualTo:  userEmail).
        get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getSnapshotStreamFromCollection(
      {required String collectionPath1,
        required String docName,
        required String collectionPath2
      }) {
    return firestore.collection(collectionPath1).
        doc(docName).
        collection(collectionPath2).snapshots();
  }

  /// Document Operations

  Future<void> deleteDocumentFromCollection(
      {required String collectionPath1,
        required String docName,
        required String collectionPath2,
        required docID
      }) async {
    return firestore.collection(collectionPath1).doc(docName).collection(collectionPath2).doc(docID).delete();
  }
  //
  // Future<DocumentSnapshot<Map<String, dynamic>>> getFromDocument(
  //     {required String collectionPath, required String documentPath}) {
  //   return firestore.collection(collectionPath).doc(documentPath).get();
  // }
  //
  Future<void> setDataOnDocument(
      {required Map<String, dynamic> data,
        required String collectionPath1,
        required String docName,
        required String collectionPath2,
        required String docID,
      }) {
    return firestore.collection(collectionPath1).
        doc(docName).
        collection(collectionPath2).
        doc(docID).
    set(data);
  }
  //
  // Stream<DocumentSnapshot<Map<String, dynamic>>> getSnapshotStreamFromDocument(
  //     {required String collectionPath, required String documentPath}) {
  //   return firestore.collection(collectionPath).doc(documentPath).snapshots();
  // }
  //
  // Future<void> updateDataOnDocument(
  //     {required Map<String, dynamic> data,
  //       required String collectionPath,
  //       required String documentPath}) {
  //   return firestore.collection(collectionPath).doc(documentPath).update(data);
  // }
}
