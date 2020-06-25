import 'package:WFHchallenge/src/resources/sign_in_repository.dart';
import 'package:WFHchallenge/src/pages/tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:WFHchallenge/src/models/user_model.dart';


class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Color darkBlue = Color.fromRGBO(28, 31, 44, 1);

  @override
  Widget build(BuildContext context) {
    final signInRepository = Provider.of<SignInRepository>(context, listen: false);
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            _welcomeToHeyMovie(),
            Spacer(),
            _googleButton(),
            if (signInRepository.appleSignInIsAvailable)
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
      margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height / 2) - 104),
    );
  }

  Widget _appleButton() {
    final signInRepository = Provider.of<SignInRepository>(context, listen: false);
    return FlatButton(
        onPressed: () async {
          UserModel user = await signInRepository.getUserInfo();
          print(user.name);

       /* String user = await signInRepository.getCurrentUser();
          print(user);*/
        },
        child: Container(
          child: Row(
            children: <Widget>[
              Image.asset('assets/IconApple.png'),
              SizedBox(
                width:10,
              ),
              Text(
                'Log In with Apple',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          margin: EdgeInsets.only(left: 60, right: 60, bottom: 76),
          padding: EdgeInsets.symmetric(horizontal: 47),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(108),
            color: darkBlue,
          ),
          height: 41,
        ));
  }

  Widget _googleButton() {
    final signInRepository = Provider.of<SignInRepository>(context, listen: false);
    return FlatButton(
        onPressed: () async {
          //  Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => GenresRecomendationView(name: 'Maria',)));

         UserModel user = await signInRepository.signinWithGoogle();
         print(user);
        },
        child: Container(
          child: Row(
            children: <Widget>[
              Image.asset('assets/GoogleIcon.png'),
              SizedBox(
                width:10 ,
              ),
              Text(
                'Log In with Google',
                style: TextStyle(
                    color: darkBlue, fontSize: 15, fontWeight: FontWeight.w500),
              )
            ],
          ),
          // margin: EdgeInsets.symmetric(horizontal: 60),
          margin: EdgeInsets.only(left: 60, right: 60, bottom: 24),
          padding: EdgeInsets.symmetric(horizontal: 47),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(108),
            color: Colors.white,
          ),
          height: 41,
        ));
  }
}
