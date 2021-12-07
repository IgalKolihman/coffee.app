import 'package:coffee_machine/cup_status_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoffeeInput extends StatefulWidget {
  final String inputName;

  const CoffeeInput({Key? key, required this.inputName}) : super(key: key);

  @override
  _CoffeeInputState createState() => _CoffeeInputState();
}

class _CoffeeInputState extends State<CoffeeInput> {
  final ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: const TextStyle(
        fontSize: 25, fontWeight: FontWeight.bold, fontFamily: "Roboto"),
    fixedSize: const Size(70, 70),
    elevation: 24.0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0))),
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(widget.inputName, style: Theme.of(context).textTheme.headline1),
          const SizedBox(width: 10),
          InputControl(inputName: widget.inputName, style: style)
        ],
      ),
    );
  }
}

class InputControl extends StatefulWidget {
  const InputControl({
    Key? key,
    required this.style,
    required this.inputName,
  }) : super(key: key);

  final String inputName;
  final ButtonStyle style;

  @override
  State<InputControl> createState() => _InputControlState();
}

class _InputControlState extends State<InputControl> {
  late TextEditingController _controller;

  @override
  void initState() {
    final CupStatus myProvider = Provider.of<CupStatus>(context, listen: false);

    super.initState();
    _controller = TextEditingController(
        text: widget.inputName == "Sugar"
            ? myProvider.sugar.toString()
            : myProvider.coffee.toString());
    _controller.addListener(() {
      if (widget.inputName == "Sugar") {
        myProvider.setSugar(_controller.text);
      } else {
        myProvider.setCoffee(_controller.text);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CupStatus>(
        builder: (context, cupStatus, child) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 40),
                inputControlButton("-", () => subtract(cupStatus)),
                const SizedBox(width: 5),
                inputControlField(context, cupStatus),
                const SizedBox(width: 5),
                inputControlButton("+", () => add(cupStatus)),
                const SizedBox(width: 40),
              ],
            ));
  }

  void add(CupStatus cupStatus) {
    switch (widget.inputName) {
      case "Sugar":
        cupStatus.addSugar();
        _controller.text = cupStatus.sugar.toString();
        break;
      default:
        cupStatus.addCoffee();
        _controller.text = cupStatus.coffee.toString();
    }
  }

  void subtract(CupStatus cupStatus) {
    switch (widget.inputName) {
      case "Sugar":
        cupStatus.removeSugar();
        cupStatus.alertError(context);
        _controller.text = cupStatus.sugar.toString();
        break;
      default:
        cupStatus.removeCoffee();
        _controller.text = cupStatus.coffee.toString();
    }
  }

  Container inputControlField(BuildContext context, CupStatus cupStatus) {
    return Container(
      constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
      child: TextField(
        textAlign: TextAlign.center,
        controller: _controller,
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20),
        decoration: const InputDecoration(
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide.none),
          fillColor: Color.fromRGBO(62, 45, 54, 1),
        ),
        onChanged: (String value) {
          _controller.text = value;
          if (widget.inputName == "Sugar") {
            cupStatus.setSugar(_controller.text);
          } else {
            cupStatus.setCoffee(_controller.text);
          }
        },
      ),
    );
  }

  ElevatedButton inputControlButton(String text, VoidCallback action) {
    return ElevatedButton(
      style: widget.style,
      onPressed: () => action(),
      child: Text(text),
    );
  }
}
