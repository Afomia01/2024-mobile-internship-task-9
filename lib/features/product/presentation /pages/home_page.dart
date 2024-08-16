import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Widgets/available_header.dart';
import '../Widgets/home_app_bar.dart';
import '../Widgets/item_card.dart';
import '../Widgets/search_button.dart';
import '../bloc/home_page/home_page_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Expanded(child: AvailableProductsHeader()),
                buildSearchButton(context),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<HomePageBloc, HomePageState>(
              builder: (context, state) {
                if (state is HomePageLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HomePageLoaded) {
                  return ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/details',
                            arguments: state.products[index],
                          );
                        },
                        child: ProductItemCard(product: state.products[index]),
                      );
                    },
                  );
                } else if (state is HomePageError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text('No products available.'));
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0), // Adjust as needed
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add_update');
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: const Color.fromARGB(255, 54, 104, 255),
          child: const Icon(
            Icons.add,
            size: 35,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
