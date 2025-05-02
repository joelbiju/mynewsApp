import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/models/news_model.dart';

class NewsService {
  static const String _apiKey = '4faadafa870d4eb581c6910aa9973fa7';

  static Future<List<NewsArticle>> fetchNews({
    required String location,
    required String earliestDate,
  }) async {
    final String url =
        'https://api.worldnewsapi.com/search-news?api-key=$_apiKey&location-filter=$location&language=en&earliest-publish-date=$earliestDate';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final newsResponse = NewsResponse.fromJson(data);
      return newsResponse.news;
    } else {
      throw Exception('Failed to load news');
    }
  }
}
