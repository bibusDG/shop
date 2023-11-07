import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop/features/order/data/datasources/user_order_data_source.dart';
import 'package:shop/features/order/data/models/user_order_model.dart';
import 'package:shop/features/order/data/repositories/user_order_repo_imp.dart';
import 'package:shop/features/order/order_failures.dart';

class MockOrderDataSource extends Mock implements UserOrderDataSource{}

void main() {

  late UserOrderDataSource dataSource;
  late UserOrderRepoImp repoImp;

  setUp((){
    dataSource = MockOrderDataSource();
    repoImp = UserOrderRepoImp(dataSource: dataSource);
  });

  const createOrderFailureMessage = CreateOrderFailure(failureMessage: 'Unable to create new order');
  const modifyOrderFailureMessage = UpdateOrderByAdminFailure(failureMessage: 'Unable to update failure status');
  final order = UserOrderModel.empty();

  group('create new order', () {

    test('should call create order and finish successfully', () async{
      when(() => dataSource.createOrder(
          userID: any(named: 'userID'),
          orderedProducts: any(named: 'orderedProducts'),
          orderID: any(named: 'orderID'),
          userEmail: any(named: 'userEmail'),
          orderNumber: any(named: 'orderNumber'),
          orderStatus: any(named: 'orderStatus'),
          orderTime: any(named: 'orderTime'),
          orderPrice: any(named: 'orderPrice'),
          paymentMethod: any(named: 'paymentMethod'),
          deliveryAddress: any(named: 'deliveryAddress'),
          deliveryMethod: any(named: 'deliveryMethod'),
          userMobile: any(named: 'userMobile'))).thenAnswer((_) => Future.value());

      final result = await repoImp.createOrder(
          userID: order.userID,
          deliveryMethod: order.deliveryMethod,
          userMobile: order.userMobile,
          orderedProducts: order.orderedProducts,
          orderID: order.orderID,
          userEmail: order.userEmail,
          orderNumber: order.orderNumber,
          orderStatus: order.orderStatus,
          orderTime: order.orderTime,
          orderPrice: order.orderPrice,
          paymentMethod: order.paymentMethod,
          deliveryAddress: order.deliveryAddress);

      expect(result, equals(const Right(null)));

    });

    test('should return failure message when create order failed', () async{
      when(() => dataSource.createOrder(
          userID: any(named: 'userID'),
          userMobile: any(named: 'userMobile'),
          deliveryMethod: any(named: 'deliveryMethod'),
          orderedProducts: any(named: 'orderedProducts'),
          orderID: any(named: 'orderID'),
          userEmail: any(named: 'userEmail'),
          orderNumber: any(named: 'orderNumber'),
          orderStatus: any(named: 'orderStatus'),
          orderTime: any(named: 'orderTime'),
          orderPrice: any(named: 'orderPrice'),
          paymentMethod: any(named: 'paymentMethod'),
          deliveryAddress: any(named: 'deliveryAddress'))).thenThrow(createOrderFailureMessage);

      final result = await repoImp.createOrder(
          userID: order.userID,
          deliveryMethod: order.deliveryMethod,
          userMobile: order.userMobile,
          orderedProducts: order.orderedProducts,
          orderID: order.orderID,
          userEmail: order.userEmail,
          orderNumber: order.orderNumber,
          orderStatus: order.orderStatus,
          orderTime: order.orderTime,
          orderPrice: order.orderPrice,
          paymentMethod: order.paymentMethod,
          deliveryAddress: order.deliveryAddress);

      expect(result, equals(Left(CreateOrderFailure(failureMessage: createOrderFailureMessage.failureMessage))));

    });

  });

  group('modify order by Admin', () {

    test('should call modify order with success', () async{

      when(() => dataSource.modifyOrderByAdmin(
          orderStatus: any(named: 'orderStatus'),
          orderID: any(named: 'orderID'))).thenAnswer((_) => Future.value());

      final result = await repoImp.modifyOrderByAdmin(
          orderStatus: order.orderStatus,
          orderID: order.orderID);

      expect(result, equals(const Right(null)));

    });

    test('should return failure message, when update order failed', () async{

      when(() => dataSource.modifyOrderByAdmin(
          orderStatus: any(named: 'orderStatus'),
          orderID: any(named: 'orderID'))).thenThrow(modifyOrderFailureMessage);

      final result = await repoImp.modifyOrderByAdmin(
          orderStatus: order.orderStatus,
          orderID: order.orderID);

      expect(result, equals(Left(UpdateOrderByAdminFailure(failureMessage: modifyOrderFailureMessage.failureMessage))));

    });

  });

  group('stream orders', () {

      test('should call stream product from data source and finish successfully', () async {
        //Arrange
        when(()=> dataSource.streamOrders(
            userEmail: any(named: 'userEmail'),
            isAdmin: any(named: 'isAdmin'))).thenAnswer((_) => Stream.value([order]));
        //Act
        final result = await dataSource.streamOrders(userEmail: order.userEmail, isAdmin: true);
        //Assert
        expect(result, emits([order]));
      });
  });

}
