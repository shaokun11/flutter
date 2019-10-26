import 'package:flutter/foundation.dart' show ChangeNotifier;
class Counter with ChangeNotifier{
  int _count = 0;
  int get count => _count;


  updateCount() {
    _count += 1;
    notifyListeners();
  }

  downCount() {
    _count -= 1;
    notifyListeners();
  }
}
