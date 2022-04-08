// coverage:ignore-file

import 'package:flutter/foundation.dart';

abstract class ViewModel<T extends Object> extends ChangeNotifier {
  Future<void> onInitialize([T? parameter]) => Future.value();
}
