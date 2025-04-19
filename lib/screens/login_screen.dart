import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/util/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formLoginKey = GlobalKey<FormState>();
  bool obscureText = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 80.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: UIColor.textPrimary,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "Please Sign in to continue",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: UIColor.textSecondary,
                    ),
                  ),
                  SizedBox(height: 50.h),
            
                  Form(
                    key: _formLoginKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: UIColor.textPrimary,
                          ),
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: 15.h, bottom: 15.h, left: 10.w),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: UIColor.shade,
                              ),
                            ),
                            hintText: 'johnmat55@gmail.com',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: UIColor.shade,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: UIColor.primaryColor,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'this field is required';
                            }
                            return null;
                          },
                        ),
            
                        SizedBox(height: 20.h),
            
                        Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: UIColor.textPrimary,
                          ),
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: 15.h, bottom: 15.h, left: 10.w),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: UIColor.shade,
                              ),
                            ),
                            hintText: '*************',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: UIColor.shade,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: UIColor.primaryColor,
                              ),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: UIColor.shade,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'this field is required';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
            
                  SizedBox(height: 80.h),
            
            
            
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: UIColor.primaryColor, // button background    // text color
                            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: (){}, 
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: UIColor.textWhite,
                            ),
                          ),
                        ),

                        SizedBox(height: 20.h),

                        RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: UIColor.textPrimary,
                            ),
                            children: [
                              TextSpan(
                                text: 'Sign up',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: UIColor.primaryColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => SignUp()));
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
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