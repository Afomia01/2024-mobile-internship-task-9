import 'package:dartz/dartz.dart';
import 'package:myapp/core/failure/failure.dart';
import 'package:myapp/core/use_case/use_case.dart';
import 'package:myapp/features/product/repository/productrepository.dart';

// Define a class to represent the parameters needed for deletion
class DeleteProductParams {
  final String id;

  DeleteProductParams({required this.id});
}

class DeleteProduct extends UseCase<Future<Either<Failure, void>>, DeleteProductParams> {
  final ProductRepository repository;

  DeleteProduct(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteProductParams params) async {
    return await repository.deleteProduct(params.id);
  }
}
