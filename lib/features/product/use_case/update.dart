import 'package:dartz/dartz.dart';

import '../../../core/failure/failure.dart';
import '../../../core/use_case/use_case.dart';
import '../domain/entities/product.dart';
import '../repository/productrepository.dart';


class UpdateProduct extends UseCase<Future<Either<Failure, void>>, Product> {
  final ProductRepository productRepository;

  UpdateProduct(this.productRepository);

  @override
  Future<Either<Failure, void>> call(Product product) async {
    return await productRepository.updateProduct(product);
  }
}
