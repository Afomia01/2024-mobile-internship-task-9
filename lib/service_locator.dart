import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/platform/network_info.dart';
import 'features/product/data/datasource/local_data_source.dart';
import 'features/product/data/datasource/remote_data_source.dart';
import 'features/product/data/repository/product_repository_impl.dart';
import 'features/product/domain/repository/productrepository.dart';
import 'features/product/domain/use_case/getAllProducts.dart';
import 'features/product/presentation/home_page/home_page_bloc.dart';

final getIt = GetIt.instance;
Future <void> Setup() async{
  var sharedPreference = await SharedPreferences.getInstance();
  var HttpClient = Client();
  var connectionChecker = InternetConnectionChecker();
  

  getIt.registerSingleton<SharedPreferences>(sharedPreference);
  getIt.registerSingleton<Client>(HttpClient);
  getIt.registerSingleton<InternetConnectionChecker>(connectionChecker);
  getIt.registerSingleton<RemoteDataSource>(RemoteDataSourceImpl(client: getIt<Client>()));
  getIt.registerSingleton<LocalDataSource>(LocalDataSourceImpl(sharedPreferences: getIt()));
  getIt.registerSingleton<NetworkInfo>(NetworkInfoImpl(connectionChecker));
  getIt.registerSingleton<ProductRepository>(ProductRepositoryImpl(remoteDataSource: getIt(), localDataSource: getIt(),networkInfo: getIt()));
  getIt.registerSingleton<GetAllProducts> (GetAllProducts(getIt()));
  getIt.registerSingleton<HomePageBloc>((getIt()));
  
}
  

