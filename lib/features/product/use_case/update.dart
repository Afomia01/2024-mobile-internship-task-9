import 'package:dartz/dartz.dart';
import 'package:myapp/core/failure/failure.dart';
import 'package:myapp/features/product/domain/entities/product.dart';
import 'package:myapp/core/use_case/use_case.dart';
import 'package:myapp/features/product/repository/productrepository.dart';


class UpdateProduct extends UseCase<Future<Either<Failure, void>>, Product> {
  final ProductRepository productRepository;

  UpdateProduct(this.productRepository);

  @override
  Future<Either<Failure, void>> call(Product product) async {
    return await productRepository.updateProduct(product);
  }
}
