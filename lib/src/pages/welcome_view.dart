import 'package:WFHchallenge/src/resources/sign_in_repository.dart';
import 'package:WFHchallenge/src/pages/tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:WFHchallenge/src/models/user_model.dart';

import 'genres_recomendation_view.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Color darkBlue = Color.fromRGBO(28, 31, 44, 1);
  Color _orange = Color.fromRGBO(235, 89, 25, 1);

  double height;
  double width;
  String userName;
  bool showProgress = false;

  @override
  Widget build(BuildContext context) {
    final signInRepository =Provider.of<SignInRepository>(context, listen: false);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            _welcomeToHeyMovie(),
            shouldShowProgreesIndicator(showProgress),
            Spacer(),
            _googleButton(),
            if (signInRepository.appleSignInIsAvailable) _appleButton()
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
    final signInRepository = Provider.of<SignInRepository>(context, listen: false);
    return FlatButton(
        onPressed: () async {
          setState(() {
            showProgress = true;
          });
          UserModel user = await signInRepository.sigInWithApple();
          determineRoute(user);
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

  void determineRoute(UserModel user) {
    if (user.genres.isEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GenresRecomendationView(
                    user: user,
                  )));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TabView()));
    }
  }

  Widget shouldShowProgreesIndicator(bool state){
    return state ? Container(child: CircularProgressIndicator(backgroundColor: _orange, strokeWidth: 5, valueColor:  AlwaysStoppedAnimation(darkBlue),),margin: EdgeInsets.only(top: 50),) :
    SizedBox(height: 5,width: 5,);
  }

  Widget _googleButton() {
    final signInRepository =
        Provider.of<SignInRepository>(context, listen: false);
    return FlatButton(
        onPressed: () async {
          setState(() {
            showProgress = true;
          });
          UserModel user = await signInRepository.signinWithGoogle();
          determineRoute(user);
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
