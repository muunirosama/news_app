import 'package:flutter/material.dart';
import 'package:news_app/cores/extensions/Padding.dart';
import 'package:news_app/modules/home/view/widgets/Category_home_view.dart';
import 'package:news_app/modules/home/view/widgets/Drawer_widget.dart';
import 'package:news_app/modules/home/view/widgets/SearchPage.dart';
import 'package:news_app/modules/home/view/widgets/Selected_Category_view.dart';
import 'package:news_app/modules/home/view_model/home_view_model.dart';

import 'package:provider/provider.dart';

import '../../../Data/network/api_network.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
    var theme= Theme.of(context);
    var provider= Provider.of<HomeViewModel>(context);
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //     onPressed: (){
      //       AbiNetwork.getAllSources("sports");
      // }
      // ),
      appBar:AppBar(
        title: Text(
          provider.selectedCategory==null? "Home": provider.selectedCategory!.categoryID
        ),
          actions: [
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()
                  ),
                );
              },
              child: const Icon(
                  Icons.search,
                size: 30,
              ).setHorizontalPadding(context,0.04),
            )
          ],
      ),
        drawer: DrawerWidget(),

        body: provider.selectedCategory==null
            ? CategoryHomeView(
          categoriesList:provider.categoriesList,
          onCategoryClicked: provider.onCategoryClicked,
        )
            : SelectedCategoryView(
          selectedCategoryModel: provider.selectedCategory!,
        ),
    );
  }

}
