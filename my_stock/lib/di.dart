import 'package:get_it/get_it.dart';
import 'package:my_stock/app/data/repository_impl/emotion_repository_impl.dart';
import 'package:my_stock/app/data/repository_impl/local_repository_impl.dart';
import 'package:my_stock/app/data/repository_impl/stock_repository_impl.dart';
import 'package:my_stock/app/data/repository_impl/user_repository_impl.dart';
import 'package:my_stock/app/data/service_impl/auth_service_impl.dart';
import 'package:my_stock/app/domain/repository_interface/emotion_repostory.dart';
import 'package:my_stock/app/domain/repository_interface/local_repository.dart';
import 'package:my_stock/app/domain/repository_interface/stock_repository.dart';
import 'package:my_stock/app/domain/repository_interface/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/domain/service_interface/auth_service.dart';

GetIt getIt = GetIt.instance;

Future<void> setup() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
  getIt.registerSingleton<AuthService>(AuthServiceFactoryImpl().createAuthService());
  getIt.registerSingleton<LocalRepository>(LocalRepositoryFactoryImpl().createLocalRepository());
  getIt.registerSingleton<StockRepository>(StockRepositoryFactoryImpl().createStockRepository());
  getIt.registerSingleton<UserRepository>(UserRepositoryFactoryImpl().createUserRepository());
  getIt.registerSingleton<EmotionRepository>(
      EmotionRepositoryFactoryImpl().createEmotionRepository());
}
