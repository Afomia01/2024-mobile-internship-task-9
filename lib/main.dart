import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/features/product/domain/entities/product.dart';
import 'package:myapp/features/product/domain/use_case/delete.dart';
import 'package:myapp/features/product/domain/use_case/getProduct.dart';
import 'package:myapp/service_locator.dart';

import 'features/product/presentation /Widgets/navigation_animation.dart';
import 'features/product/presentation /bloc/add_page/add_page_bloc.dart';
import 'features/product/presentation /bloc/details_page/details_page_bloc.dart';
import 'features/product/presentation /bloc/home_page/home_page_bloc.dart';
import 'features/product/presentation /bloc/search_page/search_page_bloc.dart';
import 'features/product/presentation /bloc/update_page/update_page_bloc.dart';
import 'features/product/presentation /pages/add_page.dart';
import 'features/product/presentation /pages/details_page.dart';
import 'features/product/presentation /pages/home_page.dart';
import 'features/product/presentation /pages/search_page.dart';
import 'features/product/presentation /pages/update_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Setup(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      title: 'Product App',
      home: BlocProvider(
        create: (context) => getIt<HomePageBloc>()..add(FetchAllProducts()),
        child: const HomePage(),
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/details':
            final product = settings.arguments as Product;
            return MaterialPageRoute(
              builder: (context) {
                return BlocProvider(
                  create: (context) => DetailsPageBloc(
                    viewProduct: getIt<ViewProduct>(),
                    deleteProduct: getIt<DeleteProduct>(),
                  )..add(FetchProductByIdEvent(product.id)),
                  child: DetailsPage(id: product.id),
                );
              },
              settings: settings,
            );
          case '/add_update':
            return SlidePageRoute(
              page: BlocProvider(
                create: (context) => AddPageBloc(
                  addProductUseCase: getIt(),
                ),
                child: const AddPage(),
              ),
            );
          case '/update':
            final product = settings.arguments as Product;
            return MaterialPageRoute(
              builder: (context) {
                return BlocProvider(
                  create: (context) => UpdatePageBloc(
                    updateProduct: getIt(),
                    deleteProduct: getIt(),
                  ),
                  child: UpdatePage(product: product),
                );
              },
              settings: settings,
            );
          case '/search':
            return MaterialPageRoute(
              builder: (context) {
                return BlocProvider(
                  create: (context) => SearchPageBloc(getIt()),
                  child: SearchPage(),
                );
              },
            );
          default:
            return MaterialPageRoute(
              builder: (context) => const HomePage(),
            );
        }
      },
    );
  }
}



