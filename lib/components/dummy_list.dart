import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DummyList extends StatelessWidget {
  const DummyList({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data list
    final List<Map<String, String>> items = List.generate(
      10,
      (index) => {
        'title': 'Item Title ${index + 1}',
        'description': 'This is the description for item ${index + 1}.',
      },
    );

    return ListView.builder(
      padding: EdgeInsets.all(12.w),
      physics: BouncingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  items[index]['title']!,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  items[index]['description']!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
