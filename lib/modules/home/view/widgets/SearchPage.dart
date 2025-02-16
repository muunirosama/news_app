import 'package:flutter/material.dart';
import 'package:news_app/cores/extensions/Padding.dart';
import 'package:provider/provider.dart';

import '../../view_model/home_view_model.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    var provider= Provider.of<HomeViewModel>(context);
    return  Scaffold(
        appBar: AppBar(
          title: Text("Search"),
        ),
            body: Column(
                children:[
                  TextField(
              cursorColor:  Colors.black,
              style:  TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: provider.isDark()? Colors.white: Colors.black
              ),
              decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color:  Colors.black
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
              color:provider.isDark()? Colors.white: Colors.black
          ),
                  ),
                  focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color:provider.isDark()? Colors.white: Colors.black
          ),
                  ),
                  prefixIcon: Icon(Icons.search,
                  size: 20,
                    color: Colors.black,
                  ),
                  suffixIcon:Icon(Icons.close,
                    size: 20,
                    color: Colors.black
                  ),
              ),
            ).setHorizontalAndVerticalPadding(context, 0.035, 0.015)
    ]
    )
    );
  }
}
