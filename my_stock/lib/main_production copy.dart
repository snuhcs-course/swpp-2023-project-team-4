import 'package:firebase_core/firebase_core.dart';
import 'package:my_stock/bootstrap.dart';

import 'app.dart';
import 'firebase_options/firebase_options_dev.dart';

void main() async {
  bootstrap(() => const App());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
