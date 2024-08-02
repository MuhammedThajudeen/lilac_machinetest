// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lilac_test/services/api_services.dart';
import 'package:lilac_test/src/utils/constants.dart';
import 'package:lilac_test/src/views/featured_courses_screen.dart';
import 'package:lilac_test/src/widgets/login_common_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 69,left: 260),
                    child: Image.asset('assets/images/login_img.png',height: 162,width: 147,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 89,left: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextWidget(text: 'Start with', fontSize: 27, fontFamily: 'Inter',fontWeight: FontWeight.w700,color: Color(0xff777AAE),),
                        const TextWidget(text: 'Lilac Infotech', fontSize: 27, fontFamily: 'Inter',fontWeight: FontWeight.w700,color: Color(0xff0E0106),),
                        const TextWidget(text: 'Enter your mobile number', fontSize: 14, fontFamily: 'Inter',fontWeight: FontWeight.w400,color: Color(0xff777AAE),),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Column(
                  children: [
                    CurvedTextField(controller: usernamecontroller, obscureText: false, hintText: 'Email/ Phone Number', ),
                    CurvedTextField(controller: passwordcontroller, obscureText: false, hintText: 'Password', ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: false,
                              onChanged: (value) {},
                            ),
                            const TextWidget(text: 'Remember Me', fontSize: 14, fontFamily: 'Inter',fontWeight: FontWeight.w400,color: Color(0xff777AAE),),
                          ],
                        ),
                        const TextWidget(text: 'Forgot Password?', fontSize: 14, fontFamily: 'Inter',fontWeight: FontWeight.w400,color: Color(0xffFF1B6F),),
                      ],
                    ),
                    SizedBox(height: 20,),
                    CustomButton(
                      onPressed: () {
                        LoginFun(usernamecontroller.text, passwordcontroller.text,context);
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => const FeaturedCourses()));
                      },
                      color: Color(0xff141E3C),
                      text: 'Login',
                      textColor: Colors.white,
                      fontWeight: FontWeight.w700,
                      isTextOnly: true,
                    ),
                    SizedBox(height: 30,),
                    TextWidget(text: 'Signup with', fontFamily: 'Inter',fontWeight: FontWeight.w400,color: Color(0xff777AAE),fontSize: 14,),
                    SizedBox(height: 30,),
                    CustomButton(
                      onPressed: () {},
                      color: Colors.white,
                      text: 'Google',
                      textColor: Color(0xff777AAE),
                      fontWeight: FontWeight.w700,
                      isTextOnly: false,
                      isBorder: true,
                    ),
                    SizedBox(height: 120,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextWidget(text: 'By signing up, you agree to our', fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: 12,color: Color(0xff141E3C),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(text: 'Terms & Conditions', fontFamily: 'Inter',fontWeight: FontWeight.w700,fontSize: 12,color: Color(0xffFF1B6F),),
                            TextWidget(text: ' &', fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: 12,color: Color(0xff141E3C),),
                            TextWidget(text: ' Privacy Policy', fontFamily: 'Inter',fontWeight: FontWeight.w700,fontSize: 12,color: Color(0xffFF1B6F),),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

LoginFun(String username,String password,BuildContext context) async{
  var strUrl = base_url + login_endpoint;
  var headerData = {
        'Content-Type': 'application/json',
      };
   var postData = {
            "userField": username,
            "password": password,
    };
    try {
       final response = await postMethodApi(postData, strUrl,headerData);
       if (response.statusCode == 200 || response.statusCode == 201) {
          Map<String, dynamic> data = json.decode(response.body);
          if (data['data'] != null) {
            if (data['data']['auth'] != null) {
              if (data['data']['auth']['access_token'] != null) {
                accessToken = data['data']['auth']['access_token'];
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FeaturedCourses()));
              }
            }
          }
       }else{
        showDialog(context: context, builder: (context) => const AlertDialog(content: Text('Invalid username or password'),));
       }
    } catch (e) {
      
    }
}