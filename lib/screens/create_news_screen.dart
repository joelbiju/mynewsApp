import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/util/colors.dart';

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
  final List<String> _categories = [
    'Construction',
    'Damage',
    'Road Block',
    'Flood',
    'Environmental',
  ];


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
          ),),
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
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: UIColor.textPrimary,
                        ),
                      ),
                      SizedBox(height: 14.h),
          
                      TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: 15.h, bottom: 15.h, left: 10.w),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: UIColor.shade,
                                ),
                              ),
                              label: Text('Title'),
                              labelStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: UIColor.primaryColor,
                                ),
                              ),
                            ),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Title is required' : null,
                      ),
            
                      SizedBox(height: 12.h),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: 15.h, bottom: 15.h, left: 10.w),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: UIColor.shade,
                                ),
                              ),
                              label: Text('Title'),
                              labelStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: UIColor.primaryColor,
                                ),
                              ),
                            ),
                        maxLines: 4,
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Description is required' : null,
                      ),
                      
                      SizedBox(height: 12.h),
                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        hint: Text('Select Category'),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              top: 15.h, bottom: 15.h, left: 10.w),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: UIColor.shade,
                                ),
                          ),
                          focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: UIColor.primaryColor,
                                ),
                              ),
                          ),
                        items: _categories
                            .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                ))
                            .toList(),
                        validator: (value) =>
                            value == null ? 'Category is required' : null,
                      ),

                      SizedBox(height: 12.h),
                      TextFormField(
                        controller: _locationController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              top: 15.h, bottom: 15.h, left: 10.w),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: UIColor.shade,
                            ),
                          ),
                          label: Text('Location'),
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: UIColor.primaryColor,
                            ),
                          ),
                        ),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Location is required' : null,
                      ),


                      SizedBox(height: 16.h),
                      // Text('Add Media (Optional)', style: TextStyle(fontSize: 16)),
                      //   SizedBox(height: 8),
                      //   Container(
                      //     height: 150,
                      //     color: Colors.grey[300],
                      //     child: Center(
                      //       child: Text('Tap to add image (not implemented)'),
                      //     ),
                      //   ),
                    ],
                  ),
                ),
                

                SizedBox(height: 20.h),
                
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: UIColor.primaryColor, // button background    // text color
                    padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: (){
                    if (_formKey.currentState!.validate()) {
                      // Submit logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('News Submitted')),
                      );
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
}