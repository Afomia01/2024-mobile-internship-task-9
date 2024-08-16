// details_page_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/features/product/domain/entities/product.dart';
import 'package:myapp/features/product/domain/use_case/delete.dart';
import 'package:myapp/features/product/domain/use_case/getProduct.dart';
import '../../../../../core/failure/failure.dart';

part 'details_page_event.dart';
part 'details_page_state.dart';

class DetailsPageBloc extends Bloc<DetailsPageEvent, DetailsPageState> {
  final ViewProduct viewProduct;
  final DeleteProduct deleteProduct;

  DetailsPageBloc({
    required this.viewProduct,
    required this.deleteProduct,
  }) : super(DetailsPageInitialState()) {
    on<FetchProductByIdEvent>(_onFetchProductByIdEvent);
    on<DeleteDetailsEvent>(_onDeleteDetailsEvent);
  }

  Future<void> _onFetchProductByIdEvent(
      FetchProductByIdEvent event, Emitter<DetailsPageState> emit) async {
    emit(DetailsPageLoadingState());

    final Either<Failure, Product> failureOrProduct =
        await viewProduct(event.productId);

    failureOrProduct.fold(
      (failure) => emit(DetailsPageErrorState(_mapFailureToMessage(failure))),
      (product) => emit(DetailsPageLoadedState(product)),
    );
  }

  Future<void> _onDeleteDetailsEvent(
      DeleteDetailsEvent event, Emitter<DetailsPageState> emit) async {
    emit(DetailsPageLoadingState());

    final Either<Failure, void> failureOrSuccess =
        await deleteProduct(event.params);

    failureOrSuccess.fold(
      (failure) => emit(DetailsPageErrorState(_mapFailureToMessage(failure))),
      (_) => emit(DetailsPageDeletedState()),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.toString();
  }
}
