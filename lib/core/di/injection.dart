import 'package:get_it/get_it.dart';

import '../../data/datasources/pizza_data_source.dart';
import '../../data/services/pizza_service.dart';
import '../../domain/repositories/pizza_repository.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Data Sources
  getIt.registerLazySingleton<PizzaDataSource>(
    () => LocalPizzaDataSource(),
  );
  
  // Repositories
  getIt.registerLazySingleton<PizzaRepository>(
    () => PizzaService(getIt<PizzaDataSource>()),
  );
}