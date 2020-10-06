import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_ui/utilities/constants.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKeyUser = GlobalKey<ScaffoldState>();
  AnimationController _controller;
  Animation<Offset> offsetTop;
  Animation<Offset> offsetBottom;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();
    offsetTop = Tween<Offset>(
      begin: Offset(0, -1.0),
      end: Offset(0.0, -0.159),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    ));
    offsetBottom = Tween<Offset>(
      begin: Offset(0, 1.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    ));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          SystemNavigator.pop();
          return Future.value(false);
        },
        child: Scaffold(
          key: _scaffoldKeyUser,
          resizeToAvoidBottomInset: false,
          resizeToAvoidBottomPadding: false,
          backgroundColor: blueColor,
          body: Stack(
            fit: StackFit.expand,
            children: [
              SlideTransition(
                position: offsetTop,
                child: Image(
                  image: AssetImage('images/login.png'),
                  fit: BoxFit.contain,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SlideTransition(
                    position: offsetTop,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 35,
                          top: 50,
                        ),
                        child: Text(
                          'Welcome',
                          style: GoogleFonts.roboto(
                            color: mainBgColor,
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.6,
                  ),
                  SlideTransition(
                    position: offsetBottom,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: FlatButton(
                            padding: EdgeInsets.all(5),
                            minWidth: width * 0.8,
                            height: 50,
                            shape: StadiumBorder(
                              side: BorderSide(
                                color: mainBgColor,
                                width: 0,
                              ),
                            ),
                            color: mainBgColor,
                            onPressed: () {
                              Navigator.popAndPushNamed(context, 'userLogin');
                            },
                            child: Text(
                              'User',
                              style: GoogleFonts.raleway(
                                color: blueColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: FlatButton(
                            padding: EdgeInsets.all(5),
                            shape: StadiumBorder(
                              side: BorderSide(
                                color: mainBgColor,
                                width: 1,
                              ),
                            ),
                            minWidth: width * 0.8,
                            height: 50,
                            color: blueColor,
                            onPressed: () {
                              Navigator.popAndPushNamed(context, 'adminLogin');
                            },
                            child: Text(
                              'Admin',
                              style: GoogleFonts.raleway(
                                color: mainBgColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
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
