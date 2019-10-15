import 'package:appidermis/pages/main.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Flutter Demo',
			theme: ThemeData(
				canvasColor: Colors.white,
				scaffoldBackgroundColor: Colors.white,
				fontFamily: 'TTCommons',
				primarySwatch: Colors.pink,
				),
			home: MainPage(),
			);
	}
}
