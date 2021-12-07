import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupStatus extends ChangeNotifier {
  /// Internal, private state of the cart.
  double sugar = 0;
  double coffee = 0;
  bool proccessing = false;

  Future<void> alertError(BuildContext context) async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.red[400],
          title: const Text('Error!',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          content: const Text(
            'I just crashed, looks like you found a bug.\nGood job 👍',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Thanks'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void addSugar() {
    if (!proccessing) {
      sugar += 1;
      notifyListeners();
    }
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
    if (coffee > 0) {
      coffee -= 1;
      notifyListeners();
    }
  }

  void clear() {
    sugar = 0;
    coffee = 0;
    notifyListeners();
  }

  void setSugar(String amount) {
    sugar = double.parse(amount);
    notifyListeners();
  }

  void setCoffee(String amount) {
    coffee = double.parse(amount);
    notifyListeners();
  }

  Future<bool> onBrew(BuildContext context) async {
    if (coffee > 100 || sugar > 100) {
      alertError(context);
      return false;
    }

    proccessing = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    proccessing = false;
    notifyListeners();

    return true;
  }
}
