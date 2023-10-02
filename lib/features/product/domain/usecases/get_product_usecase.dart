import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/core/usecases/usecases.dart';
import 'package:shop/features/product/domain/entities/product.dart';
import 'package:shop/features/product/domain/repositories/product_repo.dart';

class GetProductUseCase implements UseCasesWithParams<Product, GetProductParams>{
  final ProductRepo productRepo;
  const GetProductUseCase({required this.productRepo});

  @override
  Future<Either<Failure, Product>> call(GetProductParams params) async{

    return await productRepo.getProduct(productID: params.productID);

    // TODO: implement call
    throw UnimplementedError();
  }
}

class GetProductParams extends Equatable{
  final String productID;
  const GetProductParams({required this.productID});
  const GetProductParams.empty() : this(
    productID: 'productID'
  );

  @override
  List<Object> get props => [productID];
}