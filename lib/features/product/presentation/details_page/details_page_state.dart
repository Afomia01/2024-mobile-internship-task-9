part of 'details_page_bloc.dart';

@immutable
sealed class DetailsPageState {}

final class DetailsPageInitial extends DetailsPageState {}

final class DetailsPageLoading extends DetailsPageState {}

final class DetailsPageLoaded extends DetailsPageState {
  final List<Product> products;
  DetailsPageLoaded(this.products);
}

final class DetailsPageError extends DetailsPageState {
  final String message;
  DetailsPageError(this.message);
}
