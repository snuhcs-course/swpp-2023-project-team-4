import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_stock/app/domain/repository_interface/local_repository.dart';
import 'package:my_stock/app/domain/use_case/fetch_initial_nickname_use_case.dart';
import 'package:my_stock/app/presentation/vm/user.dart';

class UserViewModel with ChangeNotifier {
  FetchInitialNicknameUseCase _fetchInitialNicknameUseCase = FetchInitialNicknameUseCase(
    localRepository: GetIt.I<LocalRepository>(),
  );

  late UserVM user;

  UserViewModel() {
    _fetchInitialNicknameUseCase(callback: (nickname) {
      user = UserVM(nickname: nickname);
      notifyListeners();
    });
  }
}
