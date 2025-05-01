import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current user
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SafeArea(
          child: user == null
              ? Center(child: Text("No user found"))
              : FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return Center(child: Text('User data not found'));
                    }

                    var userData = snapshot.data!.data() as Map<String, dynamic>;

                    // Mobile number from Firestore
                    String phoneNumber = userData['phone'] ?? 'Not Available';

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
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
                                backgroundImage: AssetImage('assets/Guy_1.png'),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                user.displayName ?? 'No Name', // Name from Firebase
                                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                user.email ?? 'No Email', // Email from Firebase
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
                                      Text(
                                        "New Delhi", // You can customize later if you store location
                                        style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                                      ),
                                      Text(
                                        phoneNumber, // Mobile number from Firestore
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
                    );
                  },
                ),
        ),
      ),
    );
  }
}
