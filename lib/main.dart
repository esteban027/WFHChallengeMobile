import 'dart:ffi';

import 'package:WFHchallenge/src/pages/home_view.dart';
import 'package:WFHchallenge/src/pages/welcome_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:WFHchallenge/src/resources/sign_in_repository.dart';
import 'package:WFHchallenge/src/pages/tab_view.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';

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
  bool userLogged = false;

  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    final signInRepository =
        Provider.of<SignInRepository>(context, listen: false);
    final userId = signInRepository.getUserId();
    String asset = 'assets/Loader.flr';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          // FutureBuilder<int>(
          //   future: userId,
          //   builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          //     if (snapshot.connectionState == ConnectionState.done) {
          //       if (snapshot.data == 0) {
          //         return WelcomePage();
          //       } else {
          //         return TabView();
          //       }
          //     }
          //     return Container(
          //       child: Center(child: CircularProgressIndicator()),
          //     );
          //   },
          // )

          SplashScreen.navigate(
        name: asset,
        next: (context) => userLogged ? TabView() : WelcomePage(),
        until: () => getUser(context),
        startAnimation: 'Untitled',
        backgroundColor: Colors.white12,
      ),
    );
  }

  getUser(BuildContext context) async {
    final signInRepository =
        Provider.of<SignInRepository>(context, listen: false);
    final userId = signInRepository.getUserId();
    // Future.delayed(Duration(seconds: 5));
    try {
      var user = await userId;
      print(user);
      userLogged = true;
    } catch (error) {
      print(error);
      userLogged = false;
    }
  }
}
