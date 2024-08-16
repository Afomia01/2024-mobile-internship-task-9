import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:myapp/features/product/data/model/product_model.dart';
import 'package:myapp/features/product/domain/entities/product.dart';
import 'package:myapp/features/product/domain/use_case/add.dart';
import '../../../../../core/failure/failure.dart';


part 'add_page_event.dart';
part 'add_page_state.dart';

class AddPageBloc extends Bloc<AddPageEvent, AddPageState> {
  final AddProductUseCase addProductUseCase; // Updated name

  AddPageBloc({required this.addProductUseCase}) : super(AddPageInitialState()) {
    on<AddProductEvent>(_onAddProductEvent);
    // on<UpdateProductEvent>(_onUpdateProductEvent);
  }

  Future<void> _onAddProductEvent(
      AddProductEvent event, Emitter<AddPageState> emit) async {
    emit(AddPageSubmittingState());

    final Either<Failure, Product> result = await addProductUseCase(
      Product(
        id: event.product.id,
        name: event.product.name,
        description: event.product.description,
        price: event.product.price,
        imageUrl: event.product.imageUrl,
      ),
    );

    result.fold(
      (failure) => emit(AddPageErrorState(failure.toString())),
      (product) => emit(AddPageSubmittedState(product as ProductModel)),
    );
  }


}
