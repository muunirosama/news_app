import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:news_app/cores/themes/app_themes_manager.dart';
import 'package:news_app/modules/home/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

import 'cores/Services/loding_services.dart';
import 'cores/routes/app_routes.dart';
import 'firebase_options.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context)=> HomeViewModel() ,
      child: const MyApp()
  ),
  );
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<HomeViewModel>(context);
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: AppThemesManager.lightTheme,
      darkTheme: AppThemesManager.darkTheme,
      themeMode: provider.currentTheme,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(
          builder: BotToastInit()
      ),
    );
  }
}

