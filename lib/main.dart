import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/screens/create_news_screen.dart';
import 'package:myapp/screens/signup_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(423, 845),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          //home: CreateNewsScreen(),
          home: SignupScreen(),
        ),
    );
  }
}
