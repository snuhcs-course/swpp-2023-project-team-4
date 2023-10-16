import 'package:get_it/get_it.dart';

import 'app/data/service_impl/auth_service_impl.dart';
import 'app/domain/service_interface/auth_service.dart';

GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<AuthService>(AuthServiceImpl());
}
