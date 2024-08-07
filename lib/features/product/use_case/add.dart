import 'package:dartz/dartz.dart';
import 'package:myapp/core/failure/failure.dart';
import 'package:myapp/features/product/domain/entities/product.dart';
import 'package:myapp/features/product/repository/productrepository.dart';
import 'package:myapp/core/use_case/use_case.dart';
// Define a generic UseCase interface (if not already defined in your project)

// Corrected class for adding a product task
class addProduct extends UseCase<Future<Either<Failure, void>>, Product> {
  final ProductRepository repository;

  addProduct(this.repository);
  
  @override
  Future<Either<Failure, Product>> call(Product product)async {
    return await repository.addProduct(product);
  }
}
