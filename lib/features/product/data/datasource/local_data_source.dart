
import '../model/product_model.dart';

abstract class LocalDataSource{
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel>addProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
  Future<ProductModel> getProductById(String productId);
}