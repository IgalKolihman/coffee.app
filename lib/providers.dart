import 'package:flutter/cupertino.dart';

class CupStatus extends ChangeNotifier {
  /// Internal, private state of the cart.
  int sugar = 0;
  int coffee = 0;

  void addSugar() {
    sugar += 1;
    notifyListeners();
  }

  void removeSugar() {
    sugar -= 1;
    notifyListeners();
  }

  void addCoffee() {
    coffee += 1;
    notifyListeners();
  }

  void removeCoffee() {
    coffee -= 1;
    notifyListeners();
  }

  void clear() {
    sugar = 0;
    coffee = 0;
    notifyListeners();
  }

  void setSugar(String amount) {
    sugar = int.parse(amount);
    notifyListeners();
  }

  void setCoffee(String amount) {
    coffee = int.parse(amount);
    notifyListeners();
  }
}
