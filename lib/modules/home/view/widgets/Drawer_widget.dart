import 'package:flutter/material.dart';
import 'package:news_app/cores/extensions/Padding.dart';
import 'package:news_app/main.dart';
import 'package:provider/provider.dart';

import '../../../../cores/themes/color_pallete.dart';

import '../../view_model/home_view_model.dart';


class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme= Theme.of(context);
    var provider= Provider.of<HomeViewModel>(context);
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white
            ),
            child: Text("News App",
              style: theme.textTheme.headlineMedium,
            ),
          ),
          const SizedBox(height: 20,),
          GestureDetector(
            onTap: ()
            {
              navigatorKey.currentState!.pop();
              provider.goToHome();
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.home_filled,
                  size: 35,
                  color: Colors.white,
                ),
                Text("Go To Home",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white
                  ),
                ),
            ],
            ).setHorizontalPadding(context,0.04),
          ),
          const SizedBox(height: 20,),
      GestureDetector(
          onTap: (){
    if (provider.isDark()){
    provider.setCurrentTheme(ThemeMode.light);
    }
    else{
    provider.setCurrentTheme(ThemeMode.dark);
    }
    },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Icon(
              Icons.wb_sunny_outlined,
              size: 28,
              color: Colors.white,
            ),
            Text("Theme",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white
              ),
            ),
          ],
        ).setHorizontalPadding(context,0.04),
      ),
        ],
      ),
    );
  }
}
