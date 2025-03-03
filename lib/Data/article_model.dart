class ArticleModel {
  final String status;
  final List<Article> articles;

  ArticleModel({
    required this.status,
    required this.articles,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      status: json["status"] ?? "unknown",
      articles: (json["articles"] as List?)?.map((element) => Article.fromJson(element)).toList() ?? [],
    );
  }
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
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    var source = json["source"] ?? {};
    return Article(
      id: source["id"] ?? "noID",
      name: source["name"] ?? "No name",
      author: json["author"] ?? "Unknown Author",
      title: json["title"] ?? "No title",
      description: json["description"] ?? "No description",
      url: json["url"] ?? "",
      urlToImage: json["urlToImage"] ?? "",
      publishedAt: json["publishedAt"] ?? "Unknown date",
      content: json["content"] ?? "No content available",
    );
  }
}
