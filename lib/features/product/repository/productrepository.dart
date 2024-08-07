import 'package:dartz/dartz.dart';
import 'package:myapp/features/product/domain/entities/product.dart';
import 'package:myapp/core/failure/failure.dart';

abstract class ProductRepository {
  List<Product> getProduct(String params);
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, Product>> addProduct(Product product);
  Future<Either<Failure, void>> updateProduct(Product product);
  Future<Either<Failure, void>> deleteProduct(String id);
  Future<Either<Failure, Product>> getProductById(String productId);

  
}
