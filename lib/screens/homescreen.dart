import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:myapp/components/carousel.dart';
import 'package:myapp/components/dummy_list.dart';
import 'package:myapp/models/location_service.dart';
import 'package:myapp/screens/create_news_screen.dart';
import 'package:myapp/screens/profile_screen.dart';
import 'package:myapp/util/colors.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String currentAddress = "Loading location...";

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  Future<void> _loadLocation() async {
    String address = await LocationService.getCurrentAddress();
    setState(() {
      currentAddress = address;
    });
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Location
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: UIColor.textPrimary,
                              size: 22.w,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              currentAddress,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: UIColor.textPrimary,
                              ),
                            ),
                          ],
                        ),
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
                            backgroundImage: AssetImage('assets/Guy_1.png'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "Headlines",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: UIColor.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              SimpleCarousel(),
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
                      "News in Detail",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: UIColor.textPrimary,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    DummyList(),
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
