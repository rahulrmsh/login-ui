import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_ui/screens/welcome.dart';
import 'package:login_ui/utilities/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> offsetTop;
  Animation<Offset> offsetBottom;
  bool _visible = true;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..forward();
    offsetTop = Tween<Offset>(
      begin: Offset(0, 0.0),
      end: Offset(0.0, -1.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    ));
    offsetBottom = Tween<Offset>(
      begin: Offset(0, 0.0),
      end: Offset(0.0, 1.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    ));
    Timer(Duration(seconds: 5), () {
      setState(() {
        _visible = !_visible;
      });
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 4000),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return Welcome();
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return Align(
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = (MediaQuery.of(context).size.height);
    final width = (MediaQuery.of(context).size.width);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        backgroundColor: blueColor,
        body: Container(
          child: Stack(
            children: [
              SlideTransition(
                position: offsetTop,
                child: Stack(
                  children: [
                    Align(
                      child: Container(
                        color: topContainer,
                        width: width,
                        height: height * 0.50,
                      ),
                      alignment: Alignment.topCenter,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: height * 0.08),
                        child: Text(
                          'Login',
                          style: GoogleFonts.acme(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.15,
                              color: mainBgColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SlideTransition(
                position: offsetBottom,
                child: Stack(
                  children: [
                    Align(
                      child: Container(
                        color: bottomContainer,
                        width: width,
                        height: height * 0.50,
                      ),
                      alignment: Alignment.bottomCenter,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: height * 0.08),
                        child: Text(
                          'Design',
                          style: GoogleFonts.acme(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.15,
                              color: mainBgColor),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Image(
                        image: AssetImage('images/lock.png'),
                        height: height * 0.70,
                        width: width * 0.70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
