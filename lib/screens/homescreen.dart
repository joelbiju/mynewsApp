import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/components/carousel.dart';
import 'package:myapp/components/dummy_list.dart';
import 'package:myapp/screens/profile_screen.dart';
import 'package:myapp/util/colors.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //icon for location
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: UIColor.textPrimary,
                              size: 22.w,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              "Pathanamthitta",
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
                            radius: 20.w,
                            backgroundImage: AssetImage('assets/Woman_5.png'),
                          ),
                        ),
                      ],
                    ),

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
              SizedBox(height: 20.h,),


              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "News in Detail",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: UIColor.textPrimary,
                      ),
                    ),

                  DummyList(),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
