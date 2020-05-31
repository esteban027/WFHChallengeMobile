// import 'package:flutter/cupertino.dart';
import 'package:WFHchallenge/src/pages/search_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
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
      home: SearchPage(),
     );
   }
 }
// class MyApp extends StatelessWidget {
//   // Widget build(BuildContext context) {
//   //   return CupertinoApp(
//   //     title: 'app Name',
//   //     debugShowCheckedModeBanner: false,
//   //     home: FilterGenresView(),
//   //   );
//   // }
//     @override
//     Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Components'),
//       ),
//       body: FilterGenresView(),
//     );
//   }
// }