import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class UserStream {
  final StreamController<User> _controller = StreamController<User>();

  Stream<User> get stream => _controller.stream;

  void add(User user) {
    _controller.add(user);
  }

  void dispose() {
    _controller.close();
  }
}
