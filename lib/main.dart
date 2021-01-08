import 'package:flutter/material.dart';
import 'package:flutter_snake_button/pages/main_snake_buttons.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Snake Button',
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => MainSnakeButtons(),
      },
    );
  }
}
