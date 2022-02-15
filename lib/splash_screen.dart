import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_5/loginPage.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:async';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    _navigateToHome();
  }  
  _navigateToHome() async {
    await Future.delayed(Duration(microseconds: 1000),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("MyApp",
          textAlign:TextAlign.center,
            style: TextStyle(
            fontSize: 35.0,
            fontWeight: FontWeight.w400,
            fontFamily:'Festive',
              color:Color(0xff7f00ff),
              shadows: <Shadow>[
                Shadow(
                  blurRadius: 9.0,
                  color: Color(0xffe100ff),
                  offset: Offset.fromDirection(120, 12)
                )
              ]
            ),
          ),
        ),
        //baseColor: Color(0xff7f00ff),
        //highlightColor: Color(0xffe100ff)
      )
    );
  }
}