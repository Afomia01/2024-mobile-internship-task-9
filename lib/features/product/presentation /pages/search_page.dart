import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/service_locator.dart';

import '../Widgets/item_card.dart';
import '../bloc/details_page/details_page_bloc.dart';
import '../bloc/search_page/search_page_bloc.dart';
import '../bloc/search_page/search_page_event.dart';
import '../bloc/search_page/search_page_state.dart';
import 'details_page.dart'; // Update path if necessary

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  RangeValues _priceRange = RangeValues(0, 100);

  @override
  void initState() {
    super.initState();
    // Fetch all products when the page initializes
    context.read<SearchPageBloc>().add(FetchAllProductsEvent());
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Category',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 4.0),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 6.0, horizontal: 12.0),
                ),
              ),
              const SizedBox(height: 6.0),
              const Text(
                'Price',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 4.0),
              Container(
                width: double.infinity,
                child: SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 11,
                    activeTrackColor: const Color(0xFF3f41f3),
                    inactiveTrackColor: const Color(0xFFD9D9D9),
                    thumbColor: const Color(0xFF3f41f3),
                    overlayColor: const Color(0x293f41f3),
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
                  ),
                  child: RangeSlider(
                    values: _priceRange,
                    min: 0,
                    max: 100,
                    divisions: 20,
                    labels: RangeLabels(
                      _priceRange.start.round().toString(),
                      _priceRange.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _priceRange = values;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              Center(
                child: SizedBox(
                  width: 377,
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3f41f3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      // Handle apply button action
                      context.read<SearchPageBloc>().add(SearchProductsEvent(query: ""));
                    },
                    child: const Text(
                      'Apply',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            'Search Product',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        elevation: 0,
        toolbarHeight: 60,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12.0),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.arrow_forward, color: Color(0xFF3f41f3)),
                        onPressed: () {
                          // Trigger search when the user clicks the search button
                          final query = ''; // Update with actual search query if needed
                          context.read<SearchPageBloc>().add(SearchProductsEvent(query: query));
                        },
                      ),
                    ),
                    onChanged: (value) {
                      // Trigger search as the user types
                      context.read<SearchPageBloc>().add(SearchProductsEvent(query: value));
                    },
                  ),
                ),
                const SizedBox(width: 8.0),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF3f41f3),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.filter_list, color: Colors.white),
                    onPressed: _showFilterBottomSheet,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: BlocBuilder<SearchPageBloc, SearchPageState>(
                builder: (context, state) {
                  if (state is SearchPageLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchPageLoaded) {
                    return ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => DetailsPageBloc(
                                    viewProduct: getIt(),
                                    deleteProduct: getIt(),
                                  )..add(FetchProductByIdEvent(product.id)),
                                  child: DetailsPage(id: product.id),
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ItemCard(
                              products: [],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is SearchPageErrorState) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: Text('Something went wrong'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
