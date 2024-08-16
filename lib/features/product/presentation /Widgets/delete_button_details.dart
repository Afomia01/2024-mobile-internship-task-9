import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/product/domain/use_case/delete.dart';
import '../bloc/details_page/details_page_bloc.dart';

class DeleteButtonDetails extends StatelessWidget {
  final String id; // The product ID to be deleted

  const DeleteButtonDetails({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        // Trigger the delete event when the button is pressed
        BlocProvider.of<DetailsPageBloc>(context).add(
          DeleteDetailsEvent(DeleteProductParams(id: id)), // Ensure compatibility with the use case
        );
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.red),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        'DELETE',
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}
