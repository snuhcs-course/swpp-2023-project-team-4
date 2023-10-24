import 'package:my_stock/app/domain/repository_interface/local_repository.dart';
import 'package:my_stock/app/domain/result.dart';

class FetchInitialNicknameUseCase {
  final LocalRepository _localRepository;

  const FetchInitialNicknameUseCase({
    required LocalRepository localRepository,
  }) : _localRepository = localRepository;

  Future<void> call({required void Function(String nickname) callback}) async {
    final result = await _localRepository.getString(key: LocalDataKey.nickname);

    switch (result) {
      case Success(:final data):
        callback(data);
      case Fail(:final issue):
        callback('');
    }
  }
}
