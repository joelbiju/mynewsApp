import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/models/location_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String currentAddress = 'Fetching location...';

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
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                                user.displayName ?? 'No Name',
                                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                user.email ?? 'No Email',
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
                                        currentAddress,
                                        style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                                      ),
                                      Text(
                                        phoneNumber,
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
