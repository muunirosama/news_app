import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/cores/extensions/Padding.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../Data/category_model.dart';
import '../../view_model/home_view_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class SelectedCategoryView extends StatefulWidget {
  final CategoryDataModel selectedCategoryModel;

  const SelectedCategoryView({
    super.key,
    required this.selectedCategoryModel,
  });

  @override
  State<SelectedCategoryView> createState() => _SelectedCategoryViewState();
}

class _SelectedCategoryViewState extends State<SelectedCategoryView> {
  late HomeViewModel _viewModel;

  get selectedCategoryModel => null;
  @override
  void initState() {
    _viewModel = Provider.of<HomeViewModel>(context, listen: false);
    Future.wait([
      _viewModel.getAllSources(),
    ]).then(
          (value) {
        if (value[0]) {
          _viewModel.getAllArticles();
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider= Provider.of<HomeViewModel>(context);
    return Column(
      children: [
        DefaultTabController(
          length: _viewModel.sourcesList.length,
          child: TabBar(
            isScrollable: true,
            labelColor: provider.isDark()? Colors.white: Colors.black,
            unselectedLabelColor: provider.isDark()? Colors.white: Colors.black,
            tabAlignment: TabAlignment.start,
            indicatorPadding: EdgeInsets.zero,
            labelPadding: const EdgeInsets.symmetric(horizontal: 12.0),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            tabs: _viewModel.sourcesList
                .map(
                  (e) => Text(e.name),
            )
                .toList(),
            onTap: _viewModel.setSelectedSource,
          ),
        ),
        Expanded(
          child: Skeletonizer(
            enabled: _viewModel.articlesList.isEmpty,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (context, index) =>
                  InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: (){
                       _showArticleDetailsBottomSheet(context,index);
                    },
                    child: Container(
                      width: 320,
                      height: 360,
                      child: CachedNetworkImage(
                    imageUrl: _viewModel.articlesList[index].urlToImage,
                    imageBuilder: (context, imageProvider) => Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: provider.isDark()? Colors.white: Colors.black
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: provider.isDark()? Colors.white: Colors.black
                                ),
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _viewModel.articlesList[index].title,
                            style: theme.textTheme.titleMedium?.copyWith(
                                height: 1.2,
                                fontWeight: FontWeight.bold,
                              color: provider.isDark()? Colors.white: Colors.black
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _viewModel.articlesList[index].author,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    height: 1.2,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFA0A0A0),
                                  ),
                                ),
                              ),
                              Text(
                                timeago.format(DateTime.parse( _viewModel.articlesList[index].publishedAt)),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  height: 1.2,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFA0A0A0),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    placeholder: (context, url) => Container(
                      alignment: Alignment.center,
                      decoration:
                      BoxDecoration(
                          border: Border.all(
                          color: Colors.black
                      )
                      ),
                      child: const CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      color: Colors.grey,
                      size: 60,
                    ),
                                    ),
                                  ),
                  ),
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: _viewModel.articlesList.length,
            ).setHorizontalPadding(context, 0.035),
          ),
        )
      ],
    );
  }
  void _showArticleDetailsBottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                    launchUrl(
                      Uri.parse(_viewModel.articlesList[index].url ?? ""),
                      mode: LaunchMode.inAppBrowserView,
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  child: Text("View Full Article"),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Close", style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



