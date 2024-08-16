// details_page_event.dart
part of 'details_page_bloc.dart';

abstract class DetailsPageEvent extends Equatable {
  const DetailsPageEvent();

  @override
  List<Object> get props => [];
}

// Event for fetching product by ID
class FetchProductByIdEvent extends DetailsPageEvent {
  final String productId;

  const FetchProductByIdEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

// Event for deleting a product
class DeleteDetailsEvent extends DetailsPageEvent {
  final DeleteProductParams params;

  const DeleteDetailsEvent(this.params);

  @override
  List<Object> get props => [params];
}
