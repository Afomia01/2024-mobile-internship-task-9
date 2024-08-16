import 'package:bloc/bloc.dart';
import 'package:myapp/features/product/domain/entities/product.dart';
import 'package:myapp/features/product/domain/use_case/getAllProducts.dart';
import 'search_page_event.dart';
import 'search_page_state.dart';

class SearchPageBloc extends Bloc<SearchPageEvent, SearchPageState> {
  final GetAllProducts getAllProducts;
  List<Product> _originalProducts = [];

  SearchPageBloc(this.getAllProducts) : super(SearchPageInitial()) {
    on<FetchAllProductsEvent>(_onFetchAllProducts);
    on<SearchProductsEvent>(_onSearchProducts);
  }

  Future<void> _onFetchAllProducts(FetchAllProductsEvent event, Emitter<SearchPageState> emit) async {
    emit(SearchPageLoading());

    final result = await getAllProducts();
    result.fold(
      (failure) => emit(SearchPageErrorState(failure.toString())),
      (products) {
        _originalProducts = products;
        emit(SearchPageLoaded(products));
      },
    );
  }

  Future<void> _onSearchProducts(SearchProductsEvent event, Emitter<SearchPageState> emit) async {
    emit(SearchPageLoading());

    final query = event.query.trim().toLowerCase();
    if (query.isEmpty) {
      emit(SearchPageLoaded(_originalProducts));
      return;
    }

    final filteredProducts = _originalProducts.where((product) {
      return product.name.trim().toLowerCase().contains(query);
    }).toList();

    emit(SearchPageLoaded(filteredProducts));
  }
}
