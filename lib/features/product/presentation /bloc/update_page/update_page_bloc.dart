import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/features/product/domain/use_case/delete.dart';
import 'package:myapp/features/product/domain/use_case/update.dart';
import 'package:myapp/features/product/data/model/product_model.dart';

part 'update_page_event.dart';
part 'update_page_state.dart';

class UpdatePageBloc extends Bloc<UpdatePageEvent, UpdatePageState> {
  final UpdateProduct updateProduct;
  final DeleteProduct deleteProduct;

  UpdatePageBloc({
    required this.updateProduct,
    required this.deleteProduct,
  }) : super(UpdatePageInitialState()) {
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
  }

  Future<void> _onUpdateProduct(
      UpdateProductEvent event, Emitter<UpdatePageState> emit) async {
    try {
      emit(UpdatePageSubmittingState());
      final result = await updateProduct(event.product); // Pass the product directly

      result.fold(
        (failure) => emit(UpdatePageErrorState(failure.toString())),
        (_) => emit(UpdatePageSubmittedState(event.product)), // Emit success with the updated product
      );
    } catch (error) {
      emit(UpdatePageErrorState(error.toString()));
    }
  }

  Future<void> _onDeleteProduct(
      DeleteProductEvent event, Emitter<UpdatePageState> emit) async {
    emit(UpdatePageSubmittingState());
    try {
      await deleteProduct(DeleteProductParams(id: event.productId)); // Pass 'id' parameter
      emit(UpdatePageDeletedState());
    } catch (e) {
      emit(UpdatePageErrorState(e.toString()));
    }
  }
}
