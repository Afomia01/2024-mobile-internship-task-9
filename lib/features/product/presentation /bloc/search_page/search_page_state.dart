import 'package:equatable/equatable.dart';
import 'package:myapp/features/product/domain/entities/product.dart';

sealed class SearchPageState extends Equatable {
  const SearchPageState();
  
  @override
  List<Object> get props => [];
}

final class SearchPageInitial extends SearchPageState {}

final class SearchPageLoading extends SearchPageState {}

final class SearchPageLoaded extends SearchPageState {
  final List<Product> products;

  const SearchPageLoaded(this.products);

  @override
  List<Object> get props => [products];
}

final class SearchPageErrorState extends SearchPageState {
  final String message;

  const SearchPageErrorState(this.message);

  @override
  List<Object> get props => [message];
}
