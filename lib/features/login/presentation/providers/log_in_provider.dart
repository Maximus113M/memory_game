import 'package:flutter/material.dart';

class LogInProvider with ChangeNotifier {
  bool isHiden = true;
  LogInProvider();

  void toggleVisibility(StateSetter setState) {
    isHiden = !isHiden;
    setState(
      () {},
    );
    print('Mamahuevooooooooooooooooooooo');
    notifyListeners();
  }
}
