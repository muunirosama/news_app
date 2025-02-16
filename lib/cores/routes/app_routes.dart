

import 'package:flutter/material.dart';
import 'package:news_app/cores/routes/pages_routes_name.dart';
import 'package:news_app/modules/home/view/home_view.dart';
import 'package:news_app/modules/home/view/widgets/SearchPage.dart';

import '../../modules/Splash/splash_View.dart';

abstract class AppRoutes{
  static Route onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case PagesRouteName.initial:
        return MaterialPageRoute(
            builder: (context)=> const SplashView(),
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