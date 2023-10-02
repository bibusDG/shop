import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/core/usecases/usecases.dart';
import 'package:shop/features/product/domain/entities/product.dart';
import 'package:shop/features/product/domain/repositories/product_repo.dart';

class StreamProductUseCase implements UseCasesWithParams<Stream, StreamProductParams>{
  final ProductRepo productRepo;
  const StreamProductUseCase({required this.productRepo});

  @override
  Future<Either<Failure, Stream<List<Product>>>> call(StreamProductParams params) async{
    return await productRepo.fetchProducts(productCategory: params.productCategory);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class StreamProductParams extends Equatable{
  final String productCategory;
  const StreamProductParams({required this.productCategory});
  const StreamProductParams.empty() : this(
    productCategory: 'productCategoryID'
  );

  @override
  List<Object> get props => [productCategory];
}