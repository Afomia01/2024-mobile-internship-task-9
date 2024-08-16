import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/product.dart';
import '../repository/productrepository.dart';
// Define a generic UseCase interface (if not already defined in your project)

// Corrected class for adding a product task
// Rename class from addProduct to AddProductUseCase
class AddProductUseCase extends UseCase<Future<Either<Failure, Product>>, Product> {
  final ProductRepository repository;

  AddProductUseCase(this.repository);

  @override
  Future<Either<Failure, Product>> call(Product product) async {
    return await repository.addProduct(product);
  }
}
class AddProductParams {
  final Product product;
  final String imagePath;

  AddProductParams(this.product, this.imagePath);
}


