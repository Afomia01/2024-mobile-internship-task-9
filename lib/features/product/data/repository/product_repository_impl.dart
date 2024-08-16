import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repository/productrepository.dart';
import '../datasource/local_data_source.dart';
import '../datasource/remote_data_source.dart';
import '../model/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getAllProducts();
        localDataSource.cacheProducts(remoteProducts);
        return Right(remoteProducts.cast<Product>());
      } on ServerException {
        return const Left(ServerFailure(message: 'Failed to fetch products from server.'));
      }
    } else {
      try {
        final localProducts = await localDataSource.getAllProducts();
        return Right(localProducts.cast<Product>());
      } on CacheException {
        return const Left(CacheFailure(message: 'No cached data available.'));
      }
    }
  }

  @override
  Future<Either<Failure, Product>> addProduct(Product product, {File? imageFile}) async {
    if (await networkInfo.isConnected) {
      try {
        final productModel = ProductModel(
          id: product.id,
          name: product.name,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
        );

        final remoteProduct = await remoteDataSource.addProduct(productModel, imageFile!);
        localDataSource.addProduct(remoteProduct);
        return Right(remoteProduct as Product);
      } on ServerException {
        return const Left(ServerFailure(message: 'Failed to add product to server.'));
      }
    } else {
      return Left(NetworkFailure(message: 'No internet connection.'));
    }
  }

  @override
Future<Either<Failure, void>> updateProduct(Product product) async {
  if (await networkInfo.isConnected) {
    try {
      final productModel = ProductModel(
        id: product.id,
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl, // Keep the existing image URL
      );

      await remoteDataSource.updateProduct(productModel);
      localDataSource.updateProduct(productModel);
      return const Right(null);
    } on ServerException {
      return const Left(ServerFailure(message: 'Failed to update product on server.'));
    }
  } else {
    try {
      final productModel = ProductModel(
        id: product.id,
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl, 
      );
      localDataSource.updateProduct(productModel);
      return const Right(null);
    } on CacheException {
      return const Left(CacheFailure(message: 'Failed to update product locally.'));
    }
  }
}

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteProduct(id);
        localDataSource.deleteProduct(id);
        return const Right(null);
      } on ServerException {
        return const Left(ServerFailure(message: 'Failed to delete product from server.'));
      }
    } else {
      try {
        localDataSource.deleteProduct(id);
        return const Right(null);
      } on CacheException {
        return const Left(CacheFailure(message: 'Failed to delete product locally.'));
      }
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(String productId) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteDataSource.getProductById(productId);
        localDataSource.addProduct(remoteProduct);
        return Right(remoteProduct as Product);
      } on ServerException {
        return const Left(ServerFailure(message: 'Failed to fetch product from server.'));
      }
    } else {
      try {
        final localProduct = await localDataSource.getProductById(productId);
        return Right(localProduct as Product);
      } on CacheException {
        return const Left(CacheFailure(message: 'Failed to fetch product locally.'));
      }
    }
  }
  
  Failure NetworkFailure({required String message}) {
    throw UnimplementedError();
  }
}
