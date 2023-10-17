import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/core/constants/constants.dart';
import 'package:shop/features/order/data/models/order_model.dart';

abstract class OrderDataSource{
  const OrderDataSource();

  Future<void> createOrder({
    required String orderID,
    required String userEmail,
    required String orderNumber,
    required String orderStatus,
    required String orderTime,
    required double orderPrice,
    required String paymentMethod,
    required String deliveryAddress,
});


  Future<void> modifyOrderByAdmin({
    required String orderStatus,
    required String orderID,
});

}

class OrderDataSourceImp implements OrderDataSource{
  @override
  Future<void> createOrder({
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
        collection('orders').add(OrderModel(
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

}