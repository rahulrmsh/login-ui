import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_ui/utilities/constants.dart';

final _firestore = FirebaseFirestore.instance;
String userName = '';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getUserMail();
  }

  void getUserMail() async {
    try {
      await _firestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser.email.toString())
          .get()
          .then((value) {
        setState(() {
          userName = value.data()['name'];
        });
      });
    } catch (e) {
      print(e);
      Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: cardColor,
          content: Text(
            'An error occurred. Please try again later.',
            style: TextStyle(color: subTextColor),
          ),
          duration: Duration(seconds: 3)));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userName == '') {
      return WillPopScope(
        onWillPop: () {
          Navigator.popAndPushNamed(context, 'welcome');
          return Future.value(false);
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: homeBgColor,
            body: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.3),
                  child: Image(
                    image: AssetImage('images/house3.webp'),
                    fit: BoxFit.contain,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 35,
                      top: 50,
                    ),
                    child: Text(
                      'Hi User',
                      style: GoogleFonts.roboto(
                        color: homeTextColor,
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return WillPopScope(
        onWillPop: () {
          Navigator.popAndPushNamed(context, 'welcome');
          return Future.value(false);
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: homeBgColor,
            body: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.3),
                  child: Image(
                    image: AssetImage('images/house3.webp'),
                    fit: BoxFit.contain,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 35,
                      top: 50,
                    ),
                    child: Text(
                      'Hi ' + userName.toString(),
                      style: GoogleFonts.roboto(
                        color: homeTextColor,
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
