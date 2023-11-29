import 'package:get_it/get_it.dart';
import 'package:my_stock/app/domain/repository_interface/local_repository.dart';
import 'package:my_stock/app/domain/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalRepositoryImpl implements LocalRepository {
  SharedPreferences _prefs = GetIt.I<SharedPreferences>();

  @override
  Future<Result<String, LocalDataIssue>> getString({required LocalDataKey key}) async {
    String keyString = key.name;
    String? value = _prefs.getString(keyString);
    if (value == null) {
      return Fail(LocalDataIssue.notFound);
    } else {
      return Success(value);
    }
  }

  @override
  Future<Result<void, Enum>> saveString({required LocalDataKey key, required String value}) async {
    String keyString = key.name;
    await _prefs.setString(keyString, value);
    return Success(null);
  }

  @override
  Future<Result<void, Enum>> delete({required LocalDataKey key}) async {
    String keyString = key.name;
    await _prefs.remove(keyString);
    return Success(null);
  }
}

class LocalRepositoryFactoryImpl implements LocalRepositoryFactory {
  @override
  LocalRepository createLocalRepository() {
    return LocalRepositoryImpl();
  }
}
