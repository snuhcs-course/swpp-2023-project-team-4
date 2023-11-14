import 'package:get_it/get_it.dart';
import 'package:my_stock/app/data/mock_impl/mock_auth_service_impl.dart';
import 'package:my_stock/app/data/mock_impl/mock_emotion_repository_impl.dart';
import 'package:my_stock/app/data/mock_impl/mock_stock_repository_impl.dart';
import 'package:my_stock/app/data/mock_impl/mock_user_repository_impl.dart';
import 'package:my_stock/app/data/repository_impl/local_repository_impl.dart';
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
  getIt.registerSingleton<AuthService>(MockAuthServiceImpl());
  getIt.registerSingleton<LocalRepository>(LocalRepositoryImpl());
  getIt.registerSingleton<StockRepository>(MockStockRepositoryImpl());
  getIt.registerSingleton<UserRepository>(MockUserRepositoryImpl());
  getIt.registerSingleton<EmotionRepository>(MockEmotionRepositoryImpl());
}
