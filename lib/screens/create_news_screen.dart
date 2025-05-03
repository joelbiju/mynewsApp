import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myapp/util/colors.dart';
import 'package:myapp/models/location_service.dart';

class CreateNewsScreen extends StatefulWidget {
  const CreateNewsScreen({super.key});

  @override
  State<CreateNewsScreen> createState() => _CreateNewsScreenState();
}

class _CreateNewsScreenState extends State<CreateNewsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  String? _selectedCategory;
  double? latitude;
  double? longitude;

  final List<String> _categories = [
    'Construction',
    'Damage',
    'Road Block',
    'Flood',
    'Environmental',
  ];

  final Map<String, String> _categoryImages = {
    'Construction': 'assets/categories/road_construction.jpg',
    'Damage': 'assets/categories/alert.jpg',
    'Road Block': 'assets/categories/road_closed.jpg',
    'Flood': 'assets/categories/flood_alert.jpg',
    'Environmental': 'assets/categories/environmental_alert.jpg',
  };

  @override
  void initState() {
    super.initState();
    _fetchRawCoordinates();
  }

  Future<void> _fetchRawCoordinates() async {
    try {
      Position? pos = await LocationService.getCoordinates();

      if (mounted && pos != null) {
        setState(() {
          latitude = pos.latitude;
          longitude = pos.longitude;
          _locationController.text = "${latitude!.toStringAsFixed(6)}, ${longitude!.toStringAsFixed(6)}";
        });
      }
    } catch (e) {
      print('Error fetching coordinates: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch location coordinates')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UIColor.primaryColor,
        title: Text(
          'Report News',
          style: TextStyle(
            color: UIColor.textWhite,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: UIColor.textWhite),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "News In Your Neighborhood",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: UIColor.textPrimary,
                        ),
                      ),
                      SizedBox(height: 14.h),
                      TextFormField(
                        controller: _titleController,
                        decoration: _inputDecoration("Title"),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Title is required' : null,
                      ),
                      SizedBox(height: 16.h),
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 4,
                        decoration: _inputDecoration("Description"),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Description is required' : null,
                      ),
                      SizedBox(height: 16.h),
                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        hint: Text('Select Category'),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                        decoration: _inputDecoration("Category"),
                        items: _categories
                            .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                ))
                            .toList(),
                        validator: (value) =>
                            value == null ? 'Category is required' : null,
                      ),
                      SizedBox(height: 16.h),
                      TextFormField(
                        controller: _locationController,
                        readOnly: true,
                        enabled: false,
                        decoration: _inputDecoration("Location (Lat, Lng)"),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Location is required' : null,
                      ),
                      SizedBox(height: 18.h),
                      Text('Media (default)', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('This field is not editable'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        child: Container(
                          height: 150.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: _selectedCategory != null &&
                                  _categoryImages[_selectedCategory!] != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    _categoryImages[_selectedCategory!]!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    '(Please choose category first)',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: UIColor.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 26.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final user = FirebaseAuth.instance.currentUser;

                        if (user == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('User not logged in')),
                          );
                          return;
                        }

                        try {
                          final mediaUrl = _selectedCategory != null
                              ? _categoryImages[_selectedCategory!]
                              : '';

                          final rawLocation = "$latitude,$longitude";

                          await FirebaseFirestore.instance
                              .collection('news')
                              .doc(user.displayName ?? user.uid)
                              .collection('reports')
                              .add({
                                'title': _titleController.text.trim(),
                                'description': _descriptionController.text.trim(),
                                'category': _selectedCategory,
                                'location': rawLocation,
                                'latitude': latitude,
                                'longitude': longitude,
                                'mediaUrl': mediaUrl,
                                'createdAt': FieldValue.serverTimestamp(),
                              });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('News Submitted')),
                          );

                          _formKey.currentState?.reset();
                          _titleController.clear();
                          _descriptionController.clear();
                          _locationController.clear();
                          setState(() {
                            _selectedCategory = null;
                            latitude = null;
                            longitude = null;
                          });
                          _fetchRawCoordinates(); // refetch
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to submit news: $e')),
                          );
                        }
                      }
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: UIColor.textWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      contentPadding: EdgeInsets.only(top: 15.h, bottom: 15.h, left: 10.w),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: UIColor.shade),
      ),
      label: Text(label),
      labelStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: UIColor.primaryColor),
      ),
    );
  }
}
