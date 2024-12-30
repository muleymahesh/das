import 'package:das_app/data/db/DBConfig.dart';
import 'package:das_app/data/remote/ProductService.dart';
import 'package:get_it/get_it.dart';

class DependencyInjection {
  static GetIt getIt = GetIt.instance;

  static void configure() {
    getIt.registerSingleton<Productservice>(Productservice());
    getIt.registerSingleton<Dbconfig>(Dbconfig());

  }
}