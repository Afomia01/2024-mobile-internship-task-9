import 'package:dartz/dartz.dart';
import 'package:myapp/core/failure/failure.dart';
import 'package:myapp/core/use_case/no_param_use_case.dart';
import 'package:myapp/features/product/domain/entities/product.dart';
import 'package:myapp/features/product/repository/productrepository.dart';

// Suggested code may be subject to a license. Learn more: ~LicenseLog:2217369299.
class GetAllProducts extends NoParamsUseCase<Future<Either<Failure, List<Product>>>> {
  final ProductRepository repository;

  GetAllProducts(this.repository);
  
  @override
  Future<Either<Failure, List<Product>>> call() async {
    return await repository.getAllProducts();
  }
}
