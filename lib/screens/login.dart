import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_ui/utilities/constants.dart';

final _auth = FirebaseAuth.instance;

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> with TickerProviderStateMixin {
  String userMail = '';
  String userPassword = '';
  GlobalKey<ScaffoldState> _scaffoldKeyUser = GlobalKey();
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        Navigator.popAndPushNamed(context, 'welcome');
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKeyUser,
          resizeToAvoidBottomInset: false,
          resizeToAvoidBottomPadding: false,
          backgroundColor: mainBgColor,
          body: Stack(
            fit: StackFit.expand,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image(
                  image: AssetImage('images/user.png'),
                  fit: BoxFit.contain,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 35,
                        top: 50,
                      ),
                      child: Text(
                        'Login',
                        style: GoogleFonts.roboto(
                          color: mainBgColor,
                          fontSize: 56,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.1, vertical: height * 0.1),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextField(
                                  style: TextStyle(color: mainBgColor),
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) {
                                    setState(() {
                                      userMail = value;
                                    });
                                  },
                                  onSubmitted: (value) {
                                    setState(() {
                                      userMail = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Email Id",
                                      hintStyle: TextStyle(color: mainBgColor),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: mainBgColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      border: InputBorder.none),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextField(
                                  style: TextStyle(color: mainBgColor),
                                  obscureText: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  onChanged: (value) {
                                    userPassword = value;
                                  },
                                  onSubmitted: (value) {
                                    userPassword = value;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: mainBgColor),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: mainBgColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.15),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FlatButton(
                        padding: EdgeInsets.all(5),
                        minWidth: width * 0.8,
                        height: 50,
                        shape: StadiumBorder(
                          side: BorderSide(
                            color: userColor,
                            width: 0,
                          ),
                        ),
                        color: userColor,
                        onPressed: () async {
                          try {
                            final result =
                                await InternetAddress.lookup('google.com');
                            if (result.isNotEmpty &&
                                result[0].rawAddress.isNotEmpty) {
                              try {
                                if (userMail == '' || userPassword == '') {
                                  _scaffoldKeyUser.currentState.showSnackBar(
                                    SnackBar(
                                      backgroundColor: errorCardColor,
                                      content: Text(
                                        'Please Enter Your Credentials ',
                                        style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                } else {
                                  try {
                                    UserCredential newUser =
                                        await _auth.signInWithEmailAndPassword(
                                            email: userMail,
                                            password: userPassword);
                                    if (newUser != null) {
                                      Navigator.of(context)
                                          .popAndPushNamed('home');
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'user-not-found') {
                                      _scaffoldKeyUser.currentState
                                          .showSnackBar(SnackBar(
                                        backgroundColor: errorCardColor,
                                        content: Text(
                                          'No user found for that email',
                                          style: GoogleFonts.raleway(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        duration: Duration(seconds: 3),
                                      ));
                                    } else if (e.code == 'wrong-password') {
                                      _scaffoldKeyUser.currentState
                                          .showSnackBar(SnackBar(
                                        backgroundColor: errorCardColor,
                                        content: Text(
                                          'Wrong password provided for that user',
                                          style: GoogleFonts.raleway(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        duration: Duration(seconds: 3),
                                      ));
                                    }
                                  }
                                }
                              } catch (e) {
                                print(e);
                                _scaffoldKeyUser.currentState
                                    .showSnackBar(SnackBar(
                                  backgroundColor: errorCardColor,
                                  content: Text(
                                    'Wrong Username/Password ',
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  duration: Duration(seconds: 3),
                                ));
                              }
                            }
                          } catch (e) {
                            _scaffoldKeyUser.currentState.showSnackBar(SnackBar(
                              backgroundColor: errorCardColor,
                              content: Text(
                                'Check your Internet Connection ',
                                style: GoogleFonts.raleway(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              duration: Duration(seconds: 3),
                            ));
                          }
                        },
                        child: Text(
                          'Log In',
                          style: GoogleFonts.raleway(
                            color: mainBgColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
