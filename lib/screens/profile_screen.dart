import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w, vertical: 18.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1, 
                  ),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 35.w,
                      backgroundImage: AssetImage('assets/Woman_5.png'),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Barney Stinson',
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'barneystinson@gmail.com',
                      style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                    ),
                    SizedBox(height: 8.h),

                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16.h),

                    Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Location: ",
                                  style: TextStyle(fontSize: 16.sp, color: Colors.black),
                                ),
                                Text(
                                  "Phone: ",
                                  style: TextStyle(fontSize: 16.sp, color: Colors.black),
                                ),
                              ],
                            ),
                            SizedBox(width: 15.w),
                        
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //location fetched
                                Text(
                                  "New Delhi",
                                  style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                                ),
                                //phone number from database
                                Text(
                                  "+91 98765 43210",
                                  style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                                ),
                              ],
                            )
                          ],
                        ),
                  ],
                ),
              )
          
            ],
          ),
        ),
      ),
    );
  }
}