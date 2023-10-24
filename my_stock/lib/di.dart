import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/data/service_impl/auth_service_impl.dart';
import 'app/domain/service_interface/auth_service.dart';

GetIt getIt = GetIt.instance;

void setup() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
  getIt.registerSingleton<AuthService>(AuthServiceImpl());
}