import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../Data/article_model.dart';
import '../../../../Data/network/api_network.dart';
import '../../view_model/home_view_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late HomeViewModel _viewModel;
  List<Article> _articlesList = [];
  int currentPage = 1;
  String errorMessage = "";
  bool isLoading = false;
  TextEditingController controller = TextEditingController();
  bool _isViewModelInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isViewModelInitialized) {
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
      _isViewModelInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.035,
              vertical: MediaQuery.of(context).size.height * 0.015,
            ),
            child: TextField(
              onSubmitted: (value) {
                currentPage = 1;
                _search();
              },
              controller: controller,
              cursorColor: Colors.black,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: provider.isDark() ? Colors.white : Colors.black,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: provider.isDark() ? Colors.white : Colors.black,
                  ),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                  color: Colors.black,
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMessage.isNotEmpty
                ? Center(child: Text("Error: $errorMessage"))
                : _articlesList.isEmpty
                ? const Center(child: Text("No articles found"))
                : ListView.builder(
              itemCount: _articlesList.length,
              itemBuilder: (context, index) {
                var article = _articlesList[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    _showArticleDetailsBottomSheet(context, index);
                    print("Articles List: ${_articlesList.map((e) => e.title).toList()}");
                  },
                  child: Card(
                    margin: const EdgeInsets.all(10),
                    elevation: 4,
                    child: ListTile(
                      title: Text(article.title ?? "No Title"),
                      subtitle: Text(article.description ?? "No Description"),
                      leading: article.urlToImage != null
                          ? Image.network(
                        article.urlToImage!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                          : const Icon(Icons.image_not_supported),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _search() async {
    setState(() {
      isLoading = true;
      errorMessage = "";
    });

    try {
      var response = await AbiNetwork.searchArticle(
        searchQuery: controller.text,
        pageNumber: currentPage,
      );

      print("Response received: ${response.length} articles");

      setState(() {
        _articlesList = response;
        currentPage++;
      });
    } catch (e) {
      print("Error fetching articles: $e");
      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showArticleDetailsBottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),

            child: FilledButton(
                onPressed: () {
                  if (_viewModel.articlesList.isNotEmpty && index >= 0 && index < _viewModel.articlesList.length) {
                    launchUrl(
                      Uri.parse(_viewModel.articlesList[index].url ?? ""),
                      mode: LaunchMode.inAppBrowserView,
                    );
                  } else {
                    print("Invalid article index");
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Article not found!")),
                    );
                  }
                },
              style: FilledButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              child: const Text("View Full Article"),
            ),
          ),
        ],
      ),
    );
  }
}
