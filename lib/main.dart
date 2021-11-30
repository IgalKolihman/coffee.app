import 'dart:js';

import 'package:coffee_machine/coffee_input.dart';
import 'package:coffee_machine/providers.dart';
import 'package:coffee_machine/summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => CupStatus(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final MaterialColor white = const MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFFFFFF),
      200: Color(0xFFFFFFFF),
      300: Color(0xFFFFFFFF),
      400: Color(0xFFFFFFFF),
      500: Color(0xFFFFFFFF),
      600: Color(0xFFFFFFFF),
      700: Color(0xFFFFFFFF),
      800: Color(0xFFFFFFFF),
      900: Color(0xFFFFFFFF),
    },
  );

  final ColorScheme colorScheme = const ColorScheme(
      primary: Colors.white,
      primaryVariant: Colors.white30,
      secondary: Color.fromRGBO(96, 73, 80, 1),
      secondaryVariant: Color.fromRGBO(62, 45, 54, 1),
      surface: Colors.white70,
      background: Color.fromRGBO(96, 73, 80, 1),
      error: Color.fromRGBO(115, 0, 25, 1),
      onPrimary: Color.fromRGBO(96, 73, 80, 1),
      onSecondary: Colors.white,
      onSurface: Color.fromRGBO(62, 45, 54, 1),
      onBackground: Colors.white,
      onError: Color.fromRGBO(234, 79, 68, 1),
      brightness: Brightness.light);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
        ),
        primarySwatch: white,
        colorScheme: colorScheme,
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 36.0, color: Colors.white, fontFamily: "Linotype"),
          headline2: TextStyle(
              fontSize: 36.0,
              color: Color.fromRGBO(62, 45, 54, 1),
              fontFamily: "Channel"),
          bodyText1: TextStyle(
              fontSize: 24.0, color: Colors.white, fontFamily: "Roboto"),
          bodyText2: TextStyle(
              fontSize: 14.0, color: Colors.white, fontFamily: 'Roboto'),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const Color lightBrown = Color.fromRGBO(122, 95, 103, 1);
  static const Color darkBrown = Color.fromRGBO(85, 64, 70, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [lightBrown, darkBrown],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset("assets/PNG/heading.png"),
            const SizedBox(height: 50),
            const CoffeeInput(inputName: "Sugar"),
            const SizedBox(height: 25),
            const CoffeeInput(inputName: "Coffee"),
            const SizedBox(height: 25),
            const BrewButton(),
            const SizedBox(height: 50),
          ],
        ),
      ),
    ));
  }
}

class BrewButton extends StatelessWidget {
  const BrewButton({
    Key? key,
  }) : super(key: key);

  static const Color lightBlue = Color.fromRGBO(165, 216, 226, 1);
  static const Color darkBlue = Color.fromRGBO(134, 193, 207, 1);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return Container(
                height: 230,
                child: const Center(child: Summary()),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0)),
                    gradient: LinearGradient(
                        colors: [lightBlue, darkBlue],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
              );
            });
      },
      child: const Text("Brew"),
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(150, 70),
          elevation: 32.0,
          textStyle: Theme.of(context).textTheme.headline1),
    );
  }
}