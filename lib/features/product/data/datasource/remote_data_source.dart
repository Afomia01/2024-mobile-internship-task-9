import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/error/exception.dart';
import 'package:myapp/features/product/data/model/product_model.dart';

abstract class RemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> addProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
  Future<ProductModel> getProductById(String productId);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  static const String baseUrl =
      'https://g5-flutter-learning-path-be.onrender.com/api/v1/products';

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final response = await client.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)["data"];
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> addProduct(ProductModel product) async {
    throw UnimplementedError();
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProduct(String id) async {
    throw UnimplementedError();
  }

  @override
  Future<ProductModel> getProductById(String productId) async {
    throw UnimplementedError();
  }
}
