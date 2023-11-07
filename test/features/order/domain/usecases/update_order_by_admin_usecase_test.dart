import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop/features/order/domain/repositories/user_order_repo.dart';
import 'package:shop/features/order/domain/usecases/update_order_by_admin_usecase.dart';

class MockOrderRepo extends Mock implements UserOrderRepo{}

void main() {
  late UserOrderRepo repo;
  late UpdateOrderByAdminUseCase useCase;

  setUp((){

    repo = MockOrderRepo();
    useCase = UpdateOrderByAdminUseCase(orderRepo: repo);
  });
  final params = UpdateOrderParams.empty();

  test('should call UpdateOrderByAdmin useCase', () async{
    when(() => repo.modifyOrderByAdmin(
        orderStatus: any(named: 'orderStatus'),
        orderID: any(named: 'orderID'))).thenAnswer((invocation) async => const Right(null));

    final result = await useCase(params);
    expect(result, equals(const Right(null)));
    verify(() => repo.modifyOrderByAdmin(orderStatus: params.orderStatus, orderID: params.orderID)).called(1);
    verifyNoMoreInteractions(repo);

  });



}
