import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/product_model.dart';

abstract class LocalDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> addProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
  Future<ProductModel> getProductById(String productId);

  void cacheProducts(List<ProductModel> remoteProducts) {}
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
  Future<ProductModel> addProduct(ProductModel product) async {
    final jsonString = sharedPreferences.getString(cachedProductsKey);
    List<ProductModel> productList = [];

    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      productList = jsonList.map((json) => ProductModel.fromJson(json)).toList();
    }

    productList.add(product);
    final updatedJsonList = productList.map((product) => product.toJson()).toList();
    await sharedPreferences.setString(cachedProductsKey, json.encode(updatedJsonList));

    return product;
  }

 @override
  Future<void> updateProduct(ProductModel product) async {
    final jsonString = sharedPreferences.getString(cachedProductsKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      final productList = jsonList.map((json) => ProductModel.fromJson(json)).toList();

      final index = productList.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        productList[index] = product;
        final updatedJsonList = productList.map((product) => product.toJson()).toList();
        await sharedPreferences.setString(cachedProductsKey, json.encode(updatedJsonList));
      } else {
        throw Exception('Product not found');
      }
    } else {
      throw Exception('No products found');
    }
  }

  @override
Future<void> deleteProduct(String id) async {
  final jsonString = sharedPreferences.getString(cachedProductsKey);
  if (jsonString != null) {
    final List<dynamic> jsonList = json.decode(jsonString);
    final productList = jsonList.map((json) => ProductModel.fromJson(json)).toList();

    // Remove the product with the matching ID
    final updatedProductList = productList.where((product) => product.id != id).toList();
    
    // Save the updated list back to SharedPreferences
    await sharedPreferences.setString(cachedProductsKey, json.encode(updatedProductList.map((product) => product.toJson()).toList()));
  } else {
    throw Exception('No cached products found');
  }
}


  @override
  Future<ProductModel> getProductById(String productId) async {
  final jsonString = sharedPreferences.getString(cachedProductsKey);
  if (jsonString != null) {
    final List<dynamic> jsonList = json.decode(jsonString);
    final productList = jsonList.map((json) => ProductModel.fromJson(json)).toList();
    return productList.firstWhere((product) => product.id == productId, orElse: () => throw Exception('Product not found'));
  } else {
    throw Exception('No cached products found');
  }
}

  @override
  void cacheProducts(List<ProductModel> remoteProducts) {
    // TODO: implement cacheProducts
  }

}
