import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entities/product.dart';
import '../../domain/use_case/getAllProducts.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final GetAllProducts getAllProductsUseCase;

  HomePageBloc({required this.getAllProductsUseCase}) : super(HomePageInitial()) {
    on<FetchAllProducts>(_onFetchProducts);
  }

  Future<void> _onFetchProducts(FetchAllProducts event, Emitter<HomePageState> emit) async {
    emit(HomePageLoading());

    final Either<Failure, List<Product>> result = await getAllProductsUseCase();

    result.fold(
      (failure) => emit(HomePageError(_mapFailureToMessage(failure))),
      (products) => emit(HomePageLoaded(products)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return 'An error occurred. Please try again.';
  }
}
