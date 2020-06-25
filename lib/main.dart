import 'package:WFHchallenge/src/pages/welcome_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:WFHchallenge/src/resources/sign_in_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final signInRepository = await SignInRepository.check();

  runApp(Provider<SignInRepository>.value(
    value: signInRepository,
    child: MyApp(),
  ));
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
      // home: TabView(),
      home: WelcomePage(),
     );
   }
 }
