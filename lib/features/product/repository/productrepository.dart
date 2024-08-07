import 'package:dartz/dartz.dart';

import '../../../core/failure/failure.dart';
import '../domain/entities/product.dart';

abstract class ProductRepository {
  List<Product> getProduct(String params);
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, Product>> addProduct(Product product);
  Future<Either<Failure, void>> updateProduct(Product product);
  Future<Either<Failure, void>> deleteProduct(String id);
  Future<Either<Failure, Product>> getProductById(String productId);

  
}
