import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/news_model.dart';
import 'dart:math';

class CarouselService {
  static const double radiusKm = 20.0;

  static double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const earthRadius = 6371; // in kilometers
    double dLat = _degToRad(lat2 - lat1);
    double dLon = _degToRad(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(lat1)) * cos(_degToRad(lat2)) *
        sin(dLon / 2) * sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  static double _degToRad(double degree) {
    return degree * pi / 180;
  }

  static Future<List<NewsArticle>> fetchNearbyNews(double userLat, double userLng) async {
    List<NewsArticle> nearbyNews = [];

    try {
      final snapshot = await FirebaseFirestore.instance.collectionGroup('reports').get();

      for (var doc in snapshot.docs) {
        final data = doc.data();

        if (data.containsKey('latitude') && data.containsKey('longitude')) {
          double newsLat = data['latitude'];
          double newsLng = data['longitude'];

          double distance = _calculateDistance(userLat, userLng, newsLat, newsLng);

          if (distance <= radiusKm) {
            nearbyNews.add(NewsArticle(
              title: data['title'] ?? 'No title',
              text: data['description'] ?? '',
              image: data['mediaUrl'] ?? '',
              summary: data['description'] ?? '',
              publishDate: (data['createdAt'] != null)
                  ? data['createdAt'].toDate().toString().split(' ')[0]
                  : 'Unknown',
              authors: [],
            ));
          }
        }
      }
    } catch (e) {
      print('Error fetching nearby news: $e');
    }

    return nearbyNews;
  }
}
