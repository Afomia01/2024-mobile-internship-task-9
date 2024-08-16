part of 'home_page_bloc.dart';

@immutable
abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class HomePageLoading extends HomePageState {}

class HomePageLoaded extends HomePageState {
  final List<Product> products;
  HomePageLoaded(this.products);
}

class HomePageError extends HomePageState {
  final String message;
  HomePageError(this.message);
}
