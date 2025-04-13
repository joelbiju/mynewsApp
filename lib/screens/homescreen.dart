import 'package:flutter/material.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Dummy news data
    final List<Map<String, String>> newsList = [
      {
        'time': '11:57 AM | Friday, March 12, 2021',
        'title': 'Breonna Taylor’s death sparks reform',
        'subtitle': 'One year after Breonna Taylor was fatally shot by police, the city of Louisville introduces sweeping police reforms aimed at increasing transparency and accountability.',
      },
      {
        'time': '9:30 AM | Saturday, March 13, 2021',
        'title': 'Tech companies under fire',
        'subtitle': 'Major tech companies are facing global scrutiny over their handling of user data and growing concerns about misinformation spreading across their platforms.',
      },
      {
        'time': '4:45 PM | Sunday, March 14, 2021',
        'title': 'Climate change report released',
        'subtitle': 'The latest UN report warns that climate goals are at risk without urgent action. Experts call for immediate cuts in carbon emissions and investment in sustainable energy.',
      },
      {
        'time': '8:20 AM | Monday, March 15, 2021',
        'title': 'Global markets see a surge',
        'subtitle': 'Global financial markets rallied today after announcements of new economic stimulus plans and easing of trade restrictions, boosting investor confidence worldwide.',
      },
      {
        'time': '6:15 PM | Tuesday, March 16, 2021',
        'title': 'New COVID-19 variant detected',
        'subtitle': 'A highly transmissible variant of COVID-19 has been identified in several countries, prompting travel advisories and renewed focus on vaccination efforts.',
      },
      {
        'time': '10:00 AM | Wednesday, March 17, 2021',
        'title': 'Mars rover sends new photos',
        'subtitle': 'NASA’s Perseverance rover sends back high-resolution images of the Martian surface, providing scientists with valuable insights into the planet’s geology and history.',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: Text('News Live'),
      ),
      body: SafeArea(
        child: SizedBox.expand(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: newsList.map((newsItem) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: NewsCard(
                    screenWidth: screenWidth,
                    time: newsItem['time']!,
                    title: newsItem['title']!,
                    subtitle: newsItem['subtitle']!,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final double screenWidth;
  final String time;
  final String title;
  final String subtitle;

  const NewsCard({
    required this.screenWidth,
    required this.time,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.95,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            SizedBox(height: 6),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
