import 'package:WFHchallenge/src/pages/home_view.dart';
import 'package:WFHchallenge/src/pages/tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'genres_recomendation_view.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Color darkBlue = Color.fromRGBO(28, 31, 44, 1);
  double height;
  double width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            _welcomeToHeyMovie(),
            Spacer(),
            _andoridButton(),
            _appleButton()
          ],
        ),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/Hey.jpg'), fit: BoxFit.cover)),
        padding: EdgeInsets.only(top: 50),
      ),
    );
  }

  Widget _welcomeToHeyMovie() {
    return Container(
      child: Column(children: <Widget>[
        Text(
          'Welcome to',
          style: TextStyle(
              color: Colors.white, fontSize: 27, fontWeight: FontWeight.w800),
        ),
        Text(
          'Heymovie',
          style: TextStyle(
              color: Colors.white, fontSize: 27, fontWeight: FontWeight.w100),
        ),
      ]),
      margin: EdgeInsets.only(top: (height / 2) - 104),
    );
  }

  Widget _appleButton() {
    return FlatButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TabView()));
        },
        child: Container(
          child: Center(
            child: Row(
              children: <Widget>[
                Container(child: Image.asset('assets/IconApple.png')),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: Text(
                    'Log In with Apple',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
          margin: EdgeInsets.only(left: 40, right: 40, bottom: 76),
          padding: EdgeInsets.symmetric(horizontal: 47),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(108),
            color: darkBlue,
          ),
          height: 41,
        ));
  }

  Widget _andoridButton() {
    return FlatButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GenresRecomendationView(
                        name: 'Maria',
                      )));
        },
        child: Container(
          child: Center(
            child: Row(
              children: <Widget>[
                Container(child: Image.asset('assets/GoogleIcon.png')),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: Text(
                    'Log In with Google',
                    style: TextStyle(
                        color: darkBlue,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
          margin: EdgeInsets.only(left: 40, right: 40, bottom: 24),
          padding: EdgeInsets.symmetric(horizontal: 47),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(108),
            color: Colors.white,
          ),
          height: 41,
        ));
  }
}
