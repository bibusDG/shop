import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop/features/order/domain/entities/user_order.dart';
import 'package:shop/features/order/domain/repositories/user_order_repo.dart';
import 'package:shop/features/order/domain/usecases/stream_order_usecase.dart';

class MockUserOrderRepo extends Mock implements UserOrderRepo{}

void main() {

  late UserOrderRepo repo;
  late StreamOrdersUseCase useCase;

  setUp((){
    repo = MockUserOrderRepo();
    useCase = StreamOrdersUseCase(repo: repo);
  });

  final params = StreamOrderParams.empty();
  Stream<List<UserOrder>> dummyData() async*{
    yield [UserOrder.empty()];
  }
  final testResponse = dummyData();

  test('should call stream product', () async{
    when(() => repo.streamOrders(userEmail: any(named : 'userEmail'), isAdmin: any(named: 'isAdmin'))).thenAnswer((_) async => Right(testResponse));

    final result = await useCase(params);

    expect(result, equals(Right(testResponse)));
    verify(() => repo.streamOrders(userEmail: params.userEmail, isAdmin: true)).called(1);
    verifyNoMoreInteractions(repo);
  });

}
