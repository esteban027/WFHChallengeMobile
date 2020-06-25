import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import 'network.dart';
import 'package:WFHchallenge/src/models/network_models.dart';


class SignInRepository {
  SignInRepository(this.appleSignInIsAvailable);
  
  final bool appleSignInIsAvailable;
  final Network _network = Network();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();


  Future<UserModel> signinWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);

    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();

    assert(user.uid == currentUser.uid);

    final backEndUser = UserModel.buildLocal(currentUser.uid,currentUser.displayName,currentUser.email,"");
    try {
      UserModel existentUser = await _checkIfUserExist();
      return existentUser;
    } catch (_) {
      return backEndUser;
    }
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
  }

  Future<String> getCurrentUser() async {
    FirebaseUser user = await _auth.currentUser();
    return user.email;
  }

  static Future<SignInRepository> check() async {
    return SignInRepository( await AppleSignIn.isAvailable());
  }
  
  Future<UserModel> sigInWithApple() async {
      final result = await AppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);

    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential;
        final oAuthProvider = OAuthProvider(providerId: 'apple.com');
        final credential = oAuthProvider.getCredential(
            idToken: String.fromCharCodes(appleIdCredential.identityToken),
            accessToken: String.fromCharCodes(appleIdCredential.authorizationCode)
        );
        final authResult = await _auth.signInWithCredential(credential);
        final FirebaseUser user = authResult.user;

        assert(!user.isAnonymous);

        assert(await user.getIdToken() != null);

        final FirebaseUser currentUser = await _auth.currentUser();

        assert(user.uid == currentUser.uid);
        final name = appleIdCredential.fullName;

        final backEndUser = UserModel.buildLocal(currentUser.uid, name.givenName + ' ' + name.familyName,currentUser.email,"");
        try {
          UserModel existentUser = await _checkIfUserExist();
          return existentUser;
        } catch (_) {
          return backEndUser;
        }
        return backEndUser;
      case AuthorizationStatus.error:
        print(result.error.toString());
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );
      case AuthorizationStatus.cancelled:
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
    }
  }

 Future<bool>_createUser( UserModel user) async {
    try {
      UserModel backEndUser = await _network.postUser(user);
      final prefs = await SharedPreferences.getInstance();
      prefs.setInt('userID', backEndUser.id);
      return true;
    } catch (_) {
      return false;
    }
 }

 Future<UserModel> getUserInfo() async {
    final int userId = await getUserId();
    final userModel = await _network.getUser([Parameter.forFilter(FilterType.exact, 'id', userId.toString())]);
    return userModel;
 }

 Future<UserModel> _checkIfUserExist() async {
    try {
      final FirebaseUser currentUser = await _auth.currentUser();
      final currentUserFirebaseId = currentUser.uid;
      final userModel = await _network.getUser([
        Parameter.forFilter(FilterType.exact, 'external_token',
            currentUserFirebaseId.toString())
      ]);
      final prefs = await SharedPreferences.getInstance();
      prefs.setInt('userID', userModel.id);
      return userModel;
    } catch (_) {
      throw Exception("user Does Not Exist");
    }
 }

 Future<int> getUserId() async {
   final prefs = await SharedPreferences.getInstance();
   final int userId = prefs.getInt('userID') ?? 0;
   return userId;
 }
}
