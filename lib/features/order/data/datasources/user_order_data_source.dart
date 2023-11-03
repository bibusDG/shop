import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/core/constants/constants.dart';
import 'package:shop/features/basket/domain/entities/basket.dart';
import 'package:shop/features/order/data/models/user_order_model.dart';

abstract class UserOrderDataSource{
  const UserOrderDataSource();

  Future<void> createOrder({
    required String userID,
    required String orderID,
    required String userEmail,
    required String orderNumber,
    required String orderStatus,
    required String orderTime,
    required double orderPrice,
    required String paymentMethod,
    required String deliveryAddress,

    required String deliveryMethod,
    required String userMobile,
    required List<String> orderedProducts,
});


  Future<void> modifyOrderByAdmin({
    required String orderStatus,
    required String orderID,
});

  Stream<List<UserOrderModel>> streamOrders({
    required String userEmail,
    required bool isAdmin,
});

}

class UserOrderDataSourceImp implements UserOrderDataSource{
  @override
  Future<void> createOrder({
    required String userID,
    required String userMobile,
    required String deliveryMethod,
    required List<String> orderedProducts,

    required String orderID,
    required String userEmail,
    required String orderNumber,
    required String orderStatus,
    required String orderTime,
    required double orderPrice,
    required String paymentMethod,
    required String deliveryAddress}) async{

      final result = await FirebaseFirestore.instance.collection('company').
        doc(COMPANY_NAME).
        collection('orders').add(UserOrderModel(

          userID: userID,
          userMobile: userMobile,
          deliveryMethod: deliveryMethod,
          orderedProducts: orderedProducts,


          orderID: orderID,
          userEmail: userEmail,
          orderNumber: orderNumber,
          paymentMethod: paymentMethod,
          orderTime: orderTime,
          orderPrice: orderPrice,
          deliveryAddress: deliveryAddress,
          orderStatus: orderStatus).toJson());

      final docID = result.id;
      await FirebaseFirestore.instance.collection('company').
      doc(COMPANY_NAME).
      collection('orders').
      doc(docID).
      update({"orderID": docID});

    // TODO: implement createOrder
    // throw UnimplementedError();
  }

  @override
  Future<void> modifyOrderByAdmin({
    required String orderID,
    required String orderStatus
  }) async{
    await FirebaseFirestore.instance.collection('company').
    doc(COMPANY_NAME).
    collection('orders').
    doc(orderID).
    update({"orderStatus" : orderStatus});
    // TODO: implement modifyOrderByAdmin
    // throw UnimplementedError();
  }

  @override
  Stream<List<UserOrderModel>> streamOrders({
    required String userEmail,
    required bool isAdmin
  }) async* {
    if(isAdmin == true){
      yield* FirebaseFirestore.instance.
      collection('company').
      doc(COMPANY_NAME).
      collection('orders').snapshots().map((snapshot){
        return snapshot.docs.map((doc) => UserOrderModel.fromJson(doc.data())).toList();
      });
    }else{
      yield* FirebaseFirestore.instance.
      collection('company').
      doc(COMPANY_NAME).
      collection('orders').where('userEmail', isEqualTo: userEmail).snapshots().map((snapshot){
        return snapshot.docs.map((doc) => UserOrderModel.fromJson(doc.data())).toList();
      });
    }

    // TODO: implement streamOrders
    // throw UnimplementedError();
  }

}