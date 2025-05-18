import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../Data/article_model.dart';
import '../../../Data/category_model.dart';
import '../../../Data/network/api_network.dart';
import '../../../Data/source_model.dart';


class HomeViewModel extends ChangeNotifier{

  CategoryDataModel? _selectedCategory;
  int _selectedTabIndex = 0;

  List<Source> _sourceList = [];
  List<Article> _articlesList = [];

  List<CategoryDataModel> _categoriesList=[
    CategoryDataModel(
        categoryID: "general",
        categoryName: "General",
        categoryImg: "assets/images/Frame 10.png"
    ),
    CategoryDataModel(
        categoryID: "business",
        categoryName: "Business",
        categoryImg: "assets/images/Frame 11.png"
    ),
    CategoryDataModel(
        categoryID: "sports",
        categoryName: "Sports",
        categoryImg: "assets/images/Frame 12.png"
    ),
    CategoryDataModel(
        categoryID: "technology",
        categoryName: "Technology",
        categoryImg: "assets/images/Frame 13.png"
    ),
    CategoryDataModel(
        categoryID: "entertainment",
        categoryName: "Entertainment",
        categoryImg: "assets/images/Frame 14.png"
    ),
    CategoryDataModel(
        categoryID: "health",
        categoryName: "Health",
        categoryImg: "assets/images/Frame 15.png"
    ),
    CategoryDataModel(
        categoryID: "science",
        categoryName: "Science",
        categoryImg: "assets/images/Frame 16 (1).png"
    ),
  ];

  CategoryDataModel? get selectedCategory=> _selectedCategory;
  List<CategoryDataModel> get categoriesList => _categoriesList;

  List<Source> get sourcesList => _sourceList;
  List<Article> get articlesList => _articlesList;

  void setSelectedSource(int index) {
    _selectedTabIndex = index;

    getAllArticles();

    log("${_selectedTabIndex.toString()} ----- index");
    notifyListeners();
  }


  void onCategoryClicked(CategoryDataModel selectedCategory){

    _selectedCategory= selectedCategory;

    print(selectedCategory.categoryID);

    notifyListeners();

  }
  void goToHome(){
    _selectedCategory = null;
    notifyListeners();
  }

  ThemeMode currentTheme= ThemeMode.light;

  final List<String> _ThemeList=[
    "Light",
    "Dark"
  ];

  List<String> get ThemeList=> _ThemeList;

  void setCurrentTheme(ThemeMode newTheme){
    if(newTheme==currentTheme) return;
    currentTheme=newTheme;

    notifyListeners();
  }

  bool isDark(){
    return currentTheme==ThemeMode.dark;
  }

  Future<bool> getAllSources() async {
    try {
      _sourceList = await AbiNetwork.getAllSources(
        _selectedCategory!.categoryID,
      );
      notifyListeners();
      return Future.value(true);
    } catch (error) {
      return Future.value(false);
    }
  }

  Future<void> getAllArticles() async {
    _articlesList = await AbiNetwork.getAllArticles(
      _sourceList[_selectedTabIndex].id,
    );
    notifyListeners();
  }
}