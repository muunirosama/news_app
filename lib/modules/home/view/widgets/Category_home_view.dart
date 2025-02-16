import 'package:flutter/material.dart';
import 'package:news_app/cores/extensions/Padding.dart';
import 'package:provider/provider.dart';


import '../../../../Data/category_model.dart';
import '../../view_model/home_view_model.dart';


class CategoryHomeView extends StatelessWidget {

  final List<CategoryDataModel> categoriesList;
  final void Function(CategoryDataModel) onCategoryClicked;

   const CategoryHomeView({super.key,
    required this.categoriesList,
    required this.onCategoryClicked
  });

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<HomeViewModel>(context);
    var theme= Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Good Morning \nHere is Some News For You",
              style:TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: provider.isDark()? Colors.white: Colors.black
              )
          ),
          const SizedBox(height: 20,),

          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context,index)=> Stack(
                alignment: index % 2 == 0? Alignment.bottomRight: Alignment.bottomLeft,
                children: [
                  Image.asset(
                      categoriesList[index].categoryImg
                  ),
                  GestureDetector(
                    onTap: (){
                      onCategoryClicked(categoriesList[index]);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 55,
                      width: 170,
                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(85),
                      ),
                      child: Directionality(
                        textDirection:index % 2 == 0
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 15,),
                            Text("View All",
                                style: theme.textTheme.headlineSmall
                            ),
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle
                              ),
                              child: Icon(Icons.arrow_forward),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ]
            ),
            separatorBuilder: (context,index)=>SizedBox(height: 10,),
            itemCount: categoriesList.length,
          )
        ],
      ).setHorizontalAndVerticalPadding(context, 0.035,0.01),
    );
  }
}
