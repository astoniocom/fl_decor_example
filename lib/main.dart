import 'package:fl_decor_example/shape_decoration.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 16)),
          animationDuration: const Duration(milliseconds: 1500),
          shape: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return const MyShapeDecoration(
                borderGradien: LinearGradient(colors: [Colors.red, Colors.red]),
                borderWidth: 6,
              );
            }

            return const MyShapeDecoration(
              borderGradien: LinearGradient(colors: [Colors.purple, Colors.green, Colors.yellow]),
              borderWidth: 2,
            );
          }),
        )),
      ),
      home: Scaffold(
          body: Center(
        child: TextButton(
          child: const Text("Text Button"),
          onPressed: () {},
        ),
      )),
    );
  }
}
