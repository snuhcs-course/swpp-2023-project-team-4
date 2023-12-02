import 'dart:async';

class BalanceUpdateStream {
  static final _controller = StreamController<void>();

  static Stream<void> get stream => _controller.stream;

  static void add() {
    _controller.sink.add(null);
  }

  static void dispose() {
    _controller.close();
  }
}
