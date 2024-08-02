// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lilac_test/services/api_services.dart';
import 'package:lilac_test/src/utils/constants.dart';
import 'package:lilac_test/src/views/course_detail_screen.dart';
import 'package:lilac_test/src/widgets/featured_courses_widgets.dart';
import 'package:lilac_test/src/widgets/login_common_widgets.dart';

class FeaturedCourses extends StatefulWidget {
  const FeaturedCourses({super.key});

  @override
  State<FeaturedCourses> createState() => _FeaturedCoursesState();
}

class _FeaturedCoursesState extends State<FeaturedCourses> {

  @override
  void initState() {
    courselistfunc(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(onPressed: (){
        }, icon: Icon(FontAwesomeIcons.chevronLeft,size: 20,)),
        title: TextWidget(text: 'Featured Courses', fontFamily: 'Inter',fontSize: 14,fontWeight: FontWeight.w700,color: Color(0xff0E0106),),
        backgroundColor: Color(0xffFFFFFF),
        elevation: 1,
        shadowColor: Color(0xff777AAE),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.magnifyingGlass,size: 20,)),
          IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.sliders,size: 20,))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 10,bottom: 100,left: 5,right: 5),
          height: MediaQuery.of(context).size.height,
          child: GridView.builder(
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.8), 
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetailScreen()));
                },
                child: CustomCard(
                imageUrl: 'https://via.placeholder.com/150',
                smallText: 'Lancaster University',
                detailText: 'BSc (Hons) Construction Management (top-up) BSc (Hons) Construction '),
              );
            }),
        ),
      ),
    );
  }
}

courselistfunc(BuildContext context)async{
  var strUrl = base_url + course_endpoint;
  var headerData = {
        'Authorization': accessToken,
      };

  final params = {
      'skipValue': '10',
    };

    try {
       final response = await getMethodApi(strUrl,queryParams: params, header: headerData);
       if (response.statusCode == 200 || response.statusCode == 201) {
          Map<String, dynamic> data = json.decode(response.body);

       }else{
        showDialog(context: context, builder: (context) => const AlertDialog(content: Text('Invalid username or password'),));
       }
    } catch (e) {
      
    }
}