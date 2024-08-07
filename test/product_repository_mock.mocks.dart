import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:myapp/core/failure/failure.dart' as _i6;
import 'package:myapp/features/product/domain/entities/product.dart' as _i4;
import 'package:myapp/features/product/repository/productrepository.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ProductRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockProductRepository extends _i1.Mock implements _i3.ProductRepository {
  MockProductRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Either<_i6.Failure, _i4.Product>> getProductById(String? productId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getProductById,
          [productId],
        ),
        returnValue: _i5.Future<_i2.Either<_i6.Failure, _i4.Product>>.value(
            _FakeEither_0<_i6.Failure, _i4.Product>(
          this,
          Invocation.method(
            #getProductById,
            [productId],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, _i4.Product>>);

  @override
  List<_i4.Product> getProduct(String? params) => (super.noSuchMethod(
        Invocation.method(
          #getProduct,
          [params],
        ),
        returnValue: <_i4.Product>[],
      ) as List<_i4.Product>);

  @override
  _i5.Future<_i2.Either<_i6.Failure, List<_i4.Product>>> getAllProducts() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllProducts,
          [],
        ),
        returnValue:
            _i5.Future<_i2.Either<_i6.Failure, List<_i4.Product>>>.value(
                _FakeEither_0<_i6.Failure, List<_i4.Product>>(
          this,
          Invocation.method(
            #getAllProducts,
            [],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, List<_i4.Product>>>);

  @override
  _i5.Future<_i2.Either<_i6.Failure, _i4.Product>> addProduct(
          _i4.Product? product) =>
      (super.noSuchMethod(
        Invocation.method(
          #addProduct,
          [product],
        ),
        returnValue: _i5.Future<_i2.Either<_i6.Failure, _i4.Product>>.value(
            _FakeEither_0<_i6.Failure, _i4.Product>(
          this,
          Invocation.method(
            #addProduct,
            [product],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, _i4.Product>>);

  @override
  _i5.Future<_i2.Either<_i6.Failure, void>> updateProduct(
          _i4.Product? product) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateProduct,
          [product],
        ),
        returnValue: _i5.Future<_i2.Either<_i6.Failure, void>>.value(
            _FakeEither_0<_i6.Failure, void>(
          this,
          Invocation.method(
            #updateProduct,
            [product],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, void>>);

  @override
  _i5.Future<_i2.Either<_i6.Failure, void>> deleteProduct(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteProduct,
          [id],
        ),
        returnValue: _i5.Future<_i2.Either<_i6.Failure, void>>.value(
            _FakeEither_0<_i6.Failure, void>(
          this,
          Invocation.method(
            #deleteProduct,
            [id],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, void>>);
}
