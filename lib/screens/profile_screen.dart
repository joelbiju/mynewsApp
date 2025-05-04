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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
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

                    var userData =
                        snapshot.data!.data() as Map<String, dynamic>;
                    String phoneNumber = userData['phone'] ?? 'Not Available';

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 20.h),
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
                                  radius: 24.w,
                                  backgroundColor: Colors.grey[300],
                                  child: Icon(
                                    Icons.person_4_sharp,
                                    color: Colors.black54,
                                    size: 34.w,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  user.displayName ?? 'No Name',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  user.email ?? 'No Email',
                                  style: TextStyle(
                                      fontSize: 16.sp, color: Colors.grey),
                                ),
                                SizedBox(height: 8.h),
                                Divider(thickness: 1, color: Colors.grey),
                                SizedBox(height: 16.h),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Location: ",
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "Phone: ",
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 15.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          currentAddress,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          phoneNumber,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: Text(
                                "Your Contributions",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('news')
                                .doc(user.displayName ?? user.uid)
                                .collection('reports')
                                .orderBy('createdAt', descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }

                              if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 30.h),
                                    child: Text('No news submissions found.'),
                                  ),
                                );
                              }

                              final newsList = snapshot.data!.docs;

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: newsList.length,
                                itemBuilder: (context, index) {
                                  var news = newsList[index];
                                  var data =
                                      news.data() as Map<String, dynamic>;

                                  return Card(
                                    color: Colors.white,
                                    margin:
                                        EdgeInsets.symmetric(vertical: 8.h),
                                    child: ListTile(
                                      leading: data['mediaUrl'] != null
                                          ? Image.asset(
                                              data['mediaUrl'],
                                              width: 50.w,
                                              height: 50.h,
                                              fit: BoxFit.cover,
                                            )
                                          : Icon(Icons.image_not_supported),
                                      title:
                                          Text(data['title'] ?? 'No Title'),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(data['description'] ??
                                              'No Description'),
                                          SizedBox(height: 5.h),
                                          Text(
                                            data['category'] ?? '',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () async {
                                          bool confirmDelete =
                                              await showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title:
                                                  Text("Delete this report?"),
                                              content: Text(
                                                  "Are you sure you want to delete this news entry?"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(false),
                                                  child: Text("Cancel"),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(true),
                                                  child: Text("Delete"),
                                                ),
                                              ],
                                            ),
                                          );

                                          if (confirmDelete) {
                                            try {
                                              await news.reference.delete();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      "News deleted successfully."),
                                                ),
                                              );
                                            } catch (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      "Failed to delete: $e"),
                                                ),
                                              );
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
