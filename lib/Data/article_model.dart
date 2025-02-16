class ArticleModel {
  final String status;
  final List<Article> articles;

  ArticleModel({
    required this.status,
    required this.articles,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
    status: json["status"],
    articles: List.from(json["articles"])
        .map(
          (element) => Article.fromJson(element),
    )
        .toList(),
  );
}

class Article {
  final String id;
  final String name;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  Article({
    required this.id,
    required this.name,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt ,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json["source"]["id"],
      name: json["source"]["name"],
      author: json["author"] ?? "",
      title: json["title"],
      description: json["description"],
      url: json["url"],
      urlToImage: json["urlToImage"],
      publishedAt: json["publishedAt"],
      content: json["content"],
    );
  }
}