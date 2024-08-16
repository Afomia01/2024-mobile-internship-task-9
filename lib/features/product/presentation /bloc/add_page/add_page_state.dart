part of 'add_page_bloc.dart';

abstract class AddPageState extends Equatable {
  const AddPageState();
  
  @override
  List<Object> get props => [];
}

class AddPageInitialState extends AddPageState {}

class AddPageSubmittingState extends AddPageState {}

class AddPageSubmittedState extends AddPageState {
  final ProductModel product;

  const AddPageSubmittedState(this.product);

  @override
  List<Object> get props => [product];
}

class UpdatePageSubmittedState extends AddPageState {
  final ProductModel product;

  const UpdatePageSubmittedState(this.product);

  @override
  List<Object> get props => [product];
}

class AddPageErrorState extends AddPageState {
  final String message;

  const AddPageErrorState(this.message);

  @override
  List<Object> get props => [message];
}
