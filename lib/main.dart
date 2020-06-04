import 'package:WFHchallenge/src/pages/tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:WFHchallenge/src/ui/home_page.dart';

void main() {
  runApp(HomePage());
}
 
 class MyApp extends StatefulWidget {
   MyApp({Key key}) : super(key: key);
 
   @override
   _MyAppState createState() => _MyAppState();
 }
 
 class _MyAppState extends State<MyApp> {
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabBarHomeView(),
     );
   }
 }