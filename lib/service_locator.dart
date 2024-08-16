 import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:myapp/features/product/domain/use_case/add.dart';
import 'package:myapp/features/product/domain/use_case/delete.dart';
import 'package:myapp/features/product/domain/use_case/getProduct.dart';
import 'package:myapp/features/product/domain/use_case/update.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/platform/network_info.dart';
import 'features/product/data/datasource/local_data_source.dart';
import 'features/product/data/datasource/remote_data_source.dart';
import 'features/product/data/repository/product_repository_impl.dart';
import 'features/product/domain/repository/productrepository.dart';
import 'features/product/domain/use_case/getAllProducts.dart';
import 'features/product/presentation /bloc/add_page/add_page_bloc.dart';
import 'features/product/presentation /bloc/details_page/details_page_bloc.dart';
import 'features/product/presentation /bloc/home_page/home_page_bloc.dart';
import 'features/product/presentation /bloc/search_page/search_page_bloc.dart';
import 'features/product/presentation /bloc/update_page/update_page_bloc.dart';


final getIt = GetIt.instance;

Future<void> Setup() async {
  var sharedPreference = await SharedPreferences.getInstance();
  var httpClient = Client();
  var connectionChecker = InternetConnectionChecker();

  // Registering dependencies
  getIt.registerSingleton<SharedPreferences>(sharedPreference);
  getIt.registerSingleton<Client>(httpClient);
  getIt.registerSingleton<InternetConnectionChecker>(connectionChecker);
  getIt.registerSingleton<RemoteDataSource>(
      RemoteDataSourceImpl(client: getIt<Client>()));
  getIt.registerSingleton<LocalDataSource>(
      LocalDataSourceImpl(sharedPreferences: getIt()));
  getIt.registerSingleton<NetworkInfo>(NetworkInfoImpl(connectionChecker));
  getIt.registerSingleton<ProductRepository>(ProductRepositoryImpl(
    remoteDataSource: getIt(),
    localDataSource: getIt(),
    networkInfo: getIt(),
  ));
  getIt.registerSingleton<GetAllProducts>(
      GetAllProducts(getIt<ProductRepository>()));

  // Registering HomePageBloc
  getIt.registerFactory<HomePageBloc>(
    () => HomePageBloc(getAllProductsUseCase: getIt<GetAllProducts>()),
  );
  getIt.registerSingleton<ViewProduct>(ViewProduct(getIt()));
  getIt.registerSingleton<DeleteProduct>(DeleteProduct(getIt()));
  getIt.registerSingleton<UpdateProduct>(UpdateProduct(getIt()));
  getIt.registerSingleton<AddProductUseCase>(AddProductUseCase(getIt()));


  getIt.registerFactory<DetailsPageBloc>(
    () => DetailsPageBloc(viewProduct: getIt(), deleteProduct: getIt()),
  );

  getIt.registerFactory<UpdatePageBloc>(
    () => UpdatePageBloc(updateProduct: getIt(), deleteProduct: getIt()),
  );

  getIt.registerFactory<SearchPageBloc>(
    () => SearchPageBloc(getIt()),
  );
  getIt.registerSingleton<AddPageBloc>(AddPageBloc(addProductUseCase: getIt()));
}

// void main() => runApp(const MyApp());


