import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop/features/order/domain/repositories/user_order_repo.dart';
import 'package:shop/features/order/domain/usecases/create_order_usecase.dart';

class MockOrderRepo extends Mock implements UserOrderRepo{}

void main() {

  late UserOrderRepo repo;
  late CreateOrderUseCase useCase;

  setUp((){

    repo = MockOrderRepo();
    useCase = CreateOrderUseCase(orderRepo: repo);

  });

  final params = CreateOrderParams.empty();

  test('should call [Create Order usecase]', () async{
    when(() => repo.createOrder(
        userID: any(named: 'userID'),
        deliveryMethod: any(named: 'deliveryMethod'),
        userMobile: any(named: 'userMobile'),
        orderedProducts: any(named: 'orderedProducts'),
        orderID: any(named: 'orderID'),
        userEmail: any(named: 'userEmail'),
        orderNumber: any(named: 'orderNumber'),
        orderStatus: any(named: 'orderStatus'),
        orderTime: any(named: 'orderTime'),
        orderPrice: any(named: 'orderPrice'),
        paymentMethod: any(named: 'paymentMethod'),
        deliveryAddress: any(named: 'deliveryAddress'))).thenAnswer((_) async => const Right(null));

    final result = await useCase(params);
    expect(result, equals(const Right(null)));
    verify(() => repo.createOrder(
        userID: params.userID,
        deliveryMethod: params.deliveryMethod,
        userMobile: params.userMobile,
        orderedProducts: params.orderedProducts,
        orderID: params.orderID,
        userEmail: params.userEmail,
        orderNumber: params.orderNumber,
        orderStatus: params.orderStatus,
        orderTime: params.orderTime,
        orderPrice: params.orderPrice,
        paymentMethod: params.paymentMethod,
        deliveryAddress: params.deliveryAddress)).called(1);
    verifyNoMoreInteractions(repo);

  });

}
