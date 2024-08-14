import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/product_repository_impl.dart';
import '../../domain/entities/product.dart';
import '../../domain/use_case/getAllProducts.dart';
import '../Widgets/home_app_bar.dart';
import '../Widgets/item_card.dart';
import '../home_page/home_page_bloc.dart';

const Product exampleProduct = Product(
  id: '1',
  name: 'Example Product',
  description: 'This is an example product',
  price: 35,
  imageUrl: 'assets/boot.jpg',
);

class HomePage extends StatelessWidget {
  final ProductRepositoryImpl repository;
  const HomePage(this.repository, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc(
        getAllProductsUseCase:
            GetAllProducts(repository), // Pass the repository here
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
