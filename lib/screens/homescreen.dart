// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:myapp/components/carousel.dart';
import 'package:myapp/components/news_card.dart';
import 'package:myapp/main.dart';
import 'package:myapp/models/news_model.dart';
import 'package:myapp/models/location_service.dart';
import 'package:myapp/screens/create_news_screen.dart';
import 'package:myapp/screens/profile_screen.dart';
import 'package:myapp/services/carousal_service.dart';
import 'package:myapp/services/news_service.dart';
import 'package:myapp/util/colors.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> with RouteAware {
  String currentAddress = "Loading location...";
  List<NewsArticle> _newsList = [];
  List<NewsArticle> _carouselNews = [];
  bool _isLoading = true;
  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    _loadLocationAndNews();
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }


  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }


  @override
  void didPopNext() {
    print("User returned to Homescreen – refreshing carousel...");
    _loadLocationAndNews(); // Refresh your carousel here
  }





  Future<void> _loadLocationAndNews() async {
    String address = await LocationService.getCurrentAddress();

    Position? pos = await LocationService.getCoordinates();
    if (pos != null) {
      latitude = pos.latitude;
      longitude =  pos.longitude;
      print("Latitude: ${pos.latitude}, Longitude: ${pos.longitude}");
    }

    setState(() {
      currentAddress = address;
    });

    try {
      //String location = "9.225, 76.679,20"; // Replace with dynamic location if needed
      String location = "$latitude, $longitude, 20";
      String date = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 2)));

      final news = await NewsService.fetchNews(location: location, earliestDate: date);
      final nearbyCarouselNews = await CarouselService.fetchNearbyNews(latitude!, longitude!);



      // Decode each news article location
    for (var article in nearbyCarouselNews) {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(latitude!, longitude!);
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks.first;
          article.locationName = "${place.locality}, ${place.administrativeArea}";
        }
      } catch (e) {
        print("Geocoding failed for article '${article.title}': $e");
        article.locationName = "Unknown Location";
      }
    }

      setState(() {
        _newsList = news;
        _carouselNews = nearbyCarouselNews;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading news: $e');
      setState(() {
        _isLoading = false;
      });
      print('Error fetching news: $e');
    }
  }

  void _showNewsDetailsBottomSheet(String title, String date, String description, String imageUrl) {
    showModalBottomSheet(
      backgroundColor: Colors.grey[200],
      context: context,
      isScrollControlled: true, // Allow scrolling
      builder: (BuildContext context) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display image only if URL is valid and loadable
              imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200.h, // Adjust the height as needed
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          // Image has loaded successfully
                          return child;
                        } else {
                          // Show loading indicator while the image is loading
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ?? 1)
                                      : null
                                  : null,
                            ),
                          );
                        }
                      },
                      errorBuilder: (context, error, stackTrace) {
                        // Skip the image entirely if there's an error loading it
                        return SizedBox(); // No image, just an empty space
                      },
                    )
                  : SizedBox(), // No image URL, skip image entirely
              SizedBox(height: 10.h),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 10.h),
                Divider(color: Colors.black54),
                SizedBox(height: 10.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateNewsScreen(),
            ),
          );
        },
        backgroundColor: UIColor.primaryColor,
        foregroundColor: UIColor.textWhite,
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Location Display
                        Row(
                          children: [
                            Icon(
                              Icons.location_pin,
                              color: UIColor.textPrimary,
                              size: 24.w,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              currentAddress,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: UIColor.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        // Profile Button
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileScreen(),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 22.w,
                            backgroundColor: Colors.grey[300],
                            child: Icon(
                              Icons.person_4_sharp,
                              color: Colors.black54,
                              size: 30.w,
                            ),
                          ),

                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "Local Headlines",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: UIColor.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),


              // Carousel section with fallback
              _isLoading
                ? Center(child: CircularProgressIndicator(color: UIColor.primaryColor))
                : _carouselNews.isEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Center(
                          child: Text(
                            "No local news available.",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      )
                    : SimpleCarousel(
                        items: _carouselNews.map((article) {
                          return CarouselItem(
                            imageUrl: article.image,
                            headline: article.title,
                          );
                        }).toList(),
                        onTap: (item) {
                          final tappedArticle = _carouselNews.firstWhere(
                            (a) => a.title == item.headline,
                            orElse: () => _carouselNews.first, // safe fallback
                          );
                          _showNewsDetailsBottomSheet(
                            tappedArticle.title,
                            "${tappedArticle.publishDate}\n📍 ${tappedArticle.locationName ?? "Unknown"}",
                            tappedArticle.text,
                            tappedArticle.image,
                          );
                        },
                      ),


              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.all(12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      color: UIColor.textPrimary,
                      thickness: 0.5,
                    ),
                    Text(
                      "News Headlines",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: UIColor.textPrimary,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    _isLoading
                        ? Center(child: CircularProgressIndicator(color: UIColor.primaryColor,))
                        : Column(
                            children: _newsList.map((article) {
                              return NewsCard(
                                headline: article.title,
                                date: article.publishDate,
                                description: article.summary,
                                onTap: () {
                                  _showNewsDetailsBottomSheet(
                                    article.title,
                                    article.publishDate,
                                    article.text, // Use description here
                                    article.image
                                  );
                                },
                              );
                            }).toList(),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
