import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/product.dart';
import '../repository/productrepository.dart';

class ViewProduct extends UseCase<Future<Either<Failure, Product>>, String> {
  final ProductRepository repository;

  ViewProduct(this.repository);

  @override
  Future<Either<Failure, Product>> call(String productId) async {
    return await repository.getProductById(productId);
  }
}
