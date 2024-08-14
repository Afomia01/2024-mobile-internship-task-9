import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/product/domain/repository/productrepository.dart';
import 'package:myapp/features/product/domain/use_case/getAllProducts.dart';
import 'package:myapp/features/product/presentation/Widgets/home_app_bar.dart';
import 'package:myapp/features/product/presentation/Widgets/item_card.dart';
import 'package:myapp/features/product/presentation/home_page/home_page_bloc.dart';

class HomePage extends StatelessWidget {
  final ProductRepository repository;

  const HomePage(this.repository, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc(
        getAllProductsUseCase: GetAllProducts(repository),
      )..add(FetchAllProducts()),
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            if (state is HomePageLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomePageLoaded) {
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return ItemCard(product: state.products[index]);
                },
              );
            } else if (state is HomePageError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('Failed to load products'));
            }
          },
        ),
      ),
    );
  }
}
