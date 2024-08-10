import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/product_model.dart';

abstract class LocalDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> addProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
  Future<ProductModel> getProductById(String productId);
}

const String cachedProductsKey = 'CACHED_PRODUCTS';

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
Future<List<ProductModel>> getAllProducts() async {
  final jsonString = sharedPreferences.getString(cachedProductsKey);
  if (jsonString != null) {
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => ProductModel.fromJson(json)).toList();
  } else {
    return [];
  }
}


  @override
  Future<ProductModel> addProduct(ProductModel product) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateProduct(ProductModel product) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProduct(String id) {
    throw UnimplementedError();
  }

  @override
  Future<ProductModel> getProductById(String productId) {
    throw UnimplementedError();
  }
}
