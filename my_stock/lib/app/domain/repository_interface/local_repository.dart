import 'package:my_stock/app/domain/result.dart';

abstract class LocalRepository {
  Future<Result<void, Enum>> saveString({required LocalDataKey key, required String value});

  Future<Result<String, LocalDataIssue>> getString({required LocalDataKey key});

  Future<Result<void, Enum>> delete({required LocalDataKey key});
}

enum LocalDataKey {
  nickname,
}

enum LocalDataIssue {
  notFound,
}
