import 'package:dartz/dartz.dart';
import 'package:myapp/core/failure/failure.dart';
import 'package:myapp/core/use_case/use_case.dart';
import 'package:myapp/features/product/domain/entities/product.dart';
import 'package:myapp/features/product/repository/productrepository.dart';

class ViewProduct extends UseCase<Future<Either<Failure, Product>>, String> {
  final ProductRepository repository;

  ViewProduct(this.repository);

  @override
  Future<Either<Failure, Product>> call(String productId) async {
    return await repository.getProductById(productId);
  }
}