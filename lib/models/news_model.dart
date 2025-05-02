class NewsResponse {
  final List<NewsArticle> news;

  NewsResponse({required this.news});

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    var newsList = (json['news'] as List)
        .map((item) => NewsArticle.fromJson(item))
        .toList();

    return NewsResponse(news: newsList);
  }
}

class NewsArticle {
  final String title;
  final String text;
  final String summary;
  final String image;
  final String publishDate;
  final List<String> authors;

  NewsArticle({
    required this.title,
    required this.text,
    required this.summary,
    required this.image,
    required this.publishDate,
    required this.authors,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? '',
      text: json['text'] ?? '',
      summary: json['summary'] ?? '',
      image: json['image'] ?? '',
      publishDate: json['publish_date'] ?? '',
      authors: List<String>.from(json['authors'] ?? []),
    );
  }
}
