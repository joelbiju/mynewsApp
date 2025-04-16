import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/util/colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formSignupKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,

      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 50.h,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              
                  Text(
                        "Let's create an Account",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: UIColor.textTitle,
                        ),
                      ),
                      SizedBox(height: 18.h),
              
                      Form(
                        key: _formSignupKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
              
                            Text(
                              'Enter Full Name',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: UIColor.textPrimary,
                              ),
                            ),
              
                            TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 15.h, bottom: 15.h, left: 10.w),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: UIColor.textSecondary,
                                  ),
                                ),
                                hintText: 'John Mathew',
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: UIColor.textSecondary,
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
              
                            SizedBox(height: 10.h),
              
                            //Email
                            Text(
                              'Enter Email',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: UIColor.textPrimary,
                              ),
                            ),
              
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 15.h, bottom: 15.h, left: 10.w),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: UIColor.textSecondary,
                                  ),
                                ),
                                hintText: 'johnmat55@gmail.com',
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: UIColor.textSecondary,
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
              
                            SizedBox(height: 10.h),
              
              
                            //Email
                            Text(
                              'Enter Mobile Number',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: UIColor.textPrimary,
                              ),
                            ),
              
                            TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 15.h, bottom: 15.h, left: 10.w),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: UIColor.textSecondary,
                                  ),
                                ),
                                hintText: '9447839021',
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: UIColor.textSecondary,
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
                                if (value.length != 10) {
                                  return 'Please enter a 10-digit number';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10.h),
              
                            //Password
                            Text(
                              'Enter Password',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: UIColor.textPrimary,
                              ),
                            ),
              
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 15.h, bottom: 15.h, left: 10.w),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: UIColor.textSecondary,
                                  ),
                                ),
                                hintText: '*************',
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: UIColor.textSecondary,
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
              
                            },),
              
                          ],
                        ),
                      ),
              
              
                      SizedBox(height: 40.h),
                      Align(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: UIColor.textPrimary,
                            ),
                            children: [
                              TextSpan(
                                text: 'Sign in',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: UIColor.primaryColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    //route to login page
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => LoginView(),
                                    //     ),
                                    //   );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),


                      SizedBox(height: 20.h),
                      
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
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: UIColor.textWhite,
                          ),
                        ),
                        
                      )  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}