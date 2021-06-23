

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:school_app_example/screens/main.dart';

class Home extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser?> _handleSignIn() async {
    GoogleSignInAccount googleCurrentUser = _googleSignIn.currentUser;

    try{
      if(googleCurrentUser == null) googleCurrentUser = await _googleSignIn.signInSilently();
      if(googleCurrentUser == null) googleCurrentUser = await _googleSignIn.signIn();
      if(googleCurrentUser == null) return null;

      GoogleSignInAuthentication googleAuth = await googleCurrentUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final FirebaseUser? user = (await _auth.signInWithCredential(credential)).user;

      return user;
    } catch (e) {
      print (e);
      return null;
    }
  }

  void transitionNextPage(FirebaseUser? user) {
    if(user == null) return;

    Navigator.push(this.context, MaterialPageRoute(builder: (context) => NextPage(userData: user)
    ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ホーム"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // ignore: deprecated_member_use
            RaisedButton(
              child: Text('Sign in Google'),
              onPressed: () {
                _handleSignIn()
                    .then((FirebaseUser? user) => transitionNextPage(user))
                    .catchError((e) => print(e));
              },
            ),
          ]
        ),
      ),
    );
  }
}

class NextPage extends StatefulWidget {
  FirebaseUser userData;

  NextPage({Key? key, required this.userData}) : super(key: key);

  _NextPageState createState() => _NextPageState(userData);
}

class _NextPageState extends State<NextPage> {
  late FirebaseUser userData;
  String name = "";
  late String email;
  late String photoUrl;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  _NextPageState(FirebaseUser userData) {
    this.userData = userData;
    this.name = userData.displayName!;
    this.email = userData.email!;
    this.photoUrl = userData.photoUrl!;
  }

  Future<void> _handleSignOut() async {
    await FirebaseAuth.instance.signOut();
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
    Navigator.pop(this.context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ユーザー情報表示"),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(this.photoUrl),
              Text(this.name,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Text(this.email,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                child: Text('Sign Out Google'),
                onPressed: () {
                  _handleSignOut().catchError((e) => print(e));
                },
              ),
            ]),
      ),
    );
  }
}