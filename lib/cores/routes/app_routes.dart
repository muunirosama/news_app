

import 'package:flutter/material.dart';
import 'package:news_app/cores/routes/pages_routes_name.dart';
import 'package:news_app/modules/home/view/home_view.dart';
import 'package:news_app/modules/home/view/widgets/SearchPage.dart';

import '../../modules/Splash/splash_View.dart';
import '../../modules/login/forgetpassword/foget_password.dart';
import '../../modules/login/signIn/sign_in_view.dart';
import '../../modules/login/signUp/sign_up_view.dart';

abstract class AppRoutes{
  static Route onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case PagesRouteName.initial:
        return MaterialPageRoute(
            builder: (context)=> const SplashView(),
          settings: settings
        );
      case PagesRouteName.signIn:
        return MaterialPageRoute(
            builder: (context)=> const SignInView(),
            settings: settings
        );
      case PagesRouteName.signUp:
        return MaterialPageRoute(
            builder: (context)=> const SignUpView(),
            settings: settings
        );
      case PagesRouteName.forgetPassword:
        return MaterialPageRoute(
            builder: (context)=> const ForgetPassword(),
            settings: settings
        );
      case PagesRouteName.home:
        return MaterialPageRoute(
            builder: (context)=> const HomeView(),
            settings: settings
        );
      case PagesRouteName.search:
        return MaterialPageRoute(
            builder: (context)=> const SearchPage(),
            settings: settings
        );

        default:
    return MaterialPageRoute(
    builder: (context)=> const SplashView(),
    settings: settings
    );


    }
  }

}