import 'package:coffee_machine/cup_status_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IngredientDisplay extends StatelessWidget {
  final String ingredientName;
  const IngredientDisplay({Key? key, required this.ingredientName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CupStatus cupStatus = Provider.of<CupStatus>(context, listen: false);

    String ingredientAsset;
    double amount;
    switch (ingredientName) {
      case "sugar":
        ingredientAsset = "assets/PNG/sugar.png";
        amount = cupStatus.sugar;
        break;
      default:
        ingredientAsset = "assets/PNG/coffee.png";
        amount = cupStatus.coffee;
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 60, height: 60, child: Image.asset(ingredientAsset)),
          Text("$amount", style: Theme.of(context).textTheme.bodyText1)
        ],
      ),
    );
  }
}

class Summary extends StatefulWidget {
  const Summary({Key? key}) : super(key: key);

  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return Center(
      widthFactor: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 50),
          Text("Enjoy!", style: Theme.of(context).textTheme.headline2),
          const SizedBox(width: 25),
          const IngredientDisplay(ingredientName: "sugar"),
          const SizedBox(width: 10),
          const IngredientDisplay(ingredientName: "coffee"),
          const SizedBox(width: 50)
        ],
      ),
    );
  }
}
