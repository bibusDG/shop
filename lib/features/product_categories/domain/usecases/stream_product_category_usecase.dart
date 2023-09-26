import 'package:dartz/dartz.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/core/usecases/usecases.dart';
import 'package:shop/features/product_categories/domain/entities/product_category.dart';
import 'package:shop/features/product_categories/domain/repositories/product_category_repo.dart';

class StreamProductCategoryUseCase implements UseCaseWithoutParams{
  final ProductCategoryRepo productCategoryRepo;
  const StreamProductCategoryUseCase({required this.productCategoryRepo});

  @override
  Future<Either<Failure, Stream<List<ProductCategory>>>> call() async{
    return await productCategoryRepo.streamProductCategories();
    // TODO: implement call
    throw UnimplementedError();
  }
}