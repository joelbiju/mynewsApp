import 'package:flutter/material.dart';

class Abcd extends StatelessWidget {
  const Abcd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Column(
          children: [
            Text("This is page 1"),
            TextButton(
              onPressed: (){}, 
              child: Text("Go to page 2")
            )
          ],
        ),
      ),
    );
  }
}