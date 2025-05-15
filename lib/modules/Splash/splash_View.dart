import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/cores/routes/pages_routes_name.dart';

import '../../main.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
        (){
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
              PagesRouteName.signIn,
              (route)=> false,
          );
        }
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset(
              "assets/images/news_logo.png"
          )
      )
    );
  }
}
