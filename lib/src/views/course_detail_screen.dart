// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilac_test/services/api_services.dart';
import 'package:lilac_test/src/model/course_detail_model.dart';
import 'package:lilac_test/src/utils/constants.dart';
import 'package:lilac_test/src/widgets/detail_course_widgets.dart';
import 'package:lilac_test/src/widgets/login_common_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({super.key});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> with TickerProviderStateMixin{
  late TabController controller;
  Course? courseData;
  bool isLoading = true;

  @override
  void initState() {
    courseDetaillistfunc(context);
    controller = TabController(length: 7, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          topImagesection(context),
          Padding(
            padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
            child: Column(
              children: [
                TextWidget(text: 'BSc (Hons) Construction Management (top-up) BSc (Hons) Construction ', fontFamily: 'Inter',fontSize: 14,fontWeight: FontWeight.w700,color: Color(0xff0E0106),),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(FontAwesomeIcons.buildingColumns,size: 16,),
                    SizedBox(width: 10,),
                    TextWidget(text: 'Lancaster University', fontFamily: 'Inter',fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff777AAE),),
                  ],
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
          TabBar(
            isScrollable: true,
            // tabAlignment: TabAlignment.start,
            indicatorWeight: 2,
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            // labelPadding: EdgeInsets.zero,
            // padding: const EdgeInsets.only(bottom: 5),
            labelStyle: GoogleFonts.inter(
              color: Color(0xffFF1B6F),
              fontSize: 14,
              fontWeight :FontWeight.w700,
            ),
            unselectedLabelStyle: GoogleFonts.inter(
              color: Color(0xff686868),
              fontSize: 14,
              fontWeight : FontWeight.w400,
            ),
            indicatorColor: Color(0xffFF1B6F),
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            controller: controller,
          
            tabs: const [
              Tab(
                text: 'Course',
                height: 20,
              ),
              Tab(
                text: 'Eligibility',
                height: 20,
              ),
              Tab(
                text: 'University',
                height: 20,
              ),
              Tab(
                text: 'Entrance',
                height: 20,
                
              ),
              Tab(
                text: 'Syllabus',
                height: 20,
              ),
              Tab(
                text: 'Fee Structure',
                height: 20,
              ),
              Tab(
                text: 'Documents',
                height: 20,
              ),
              // Visibility(
              //   visible: false,
              //   child: Tab(
              //     text: 'Solutions',
              //     height: 25,
              //   ),
              // ),
            ],
          ),
          Expanded(
            child: TabBarView(
              clipBehavior: Clip.none,
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              children: [
                isLoading ? Center(child: CircularProgressIndicator(),) :
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        rowHeadingWidget(FontAwesomeIcons.check, 'Eligibility'),
                        Row(
                          children: List.generate(courseData!.data.eligibileCerteriaEntrance.length, (index) {
                            return roundContainer(courseData!.data.courseIntaks[index].intakeDate.toString(),null );
                          }),),
                        SizedBox(height: 10,),
                        Divider(thickness: 1.5,),
                        rowHeadingWidget(FontAwesomeIcons.check, 'Course Duration'),
                        roundContainer(courseData!.data.courseDuration, MediaQuery.of(context).size.width),
                        SizedBox(height: 10,),
                        Divider(thickness: 1.5,),
                        rowHeadingWidget(FontAwesomeIcons.info, 'Course Intakes'),
                        Row(
                          children: List.generate(courseData!.data.courseIntaks.length, (index) {
                            return roundContainer(courseData!.data.courseIntaks[index].intakeDate.toString(),null );
                          })
                        ),
                        SizedBox(height: 10,),
                        Divider(thickness: 1.5,),
                        rowHeadingWidget(FontAwesomeIcons.buildingColumns, 'University'),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextWidget(text: courseData!.data.universityName, fontFamily: 'Inter',fontSize: 14,fontWeight: FontWeight.w700,color: Color(0xff777AAE),)),
                        SizedBox(height: 10,),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(courseData!.data.aboutUniversity)),
                        SizedBox(height: 10,),
                        universityRow('${courseData!.data.universityCity},${courseData!.data.universityState}', FontAwesomeIcons.locationPin),
                        SizedBox(height: 10,),
                        universityRow('${courseData!.data.universityRank}', FontAwesomeIcons.rankingStar),
                        SizedBox(height: 10,),
                        CustomButtonDownload(text: 'Download University Brochure',onPressed: (){
                          launchUrl(Uri.parse(courseData!.data.universityBrochure));
                        }, isTextOnly: false, color: Color(0xffF0F2F5),textColor: Colors.black,),
                        SizedBox(height: 10,),
                        Divider(thickness: 1.5,),
                        rowHeadingWidget(FontAwesomeIcons.bookOpen, 'Course syllabus'),
                         Align(
                          alignment: Alignment.centerLeft,
                          child: TextWidget(text: courseData!.data.courseSyllabus, fontFamily: 'Inter',fontSize: 14,fontWeight: FontWeight.w700,color: Color(0xff777AAE),)),
                        SizedBox(height: 10,),
                        CustomButtonDownload(text: 'Download Course Syllabus',onPressed: (){
                          launchUrl(Uri.parse(courseData!.data.courseSyllabusPdf));
                        }, isTextOnly: false, color: Color(0xffF0F2F5),textColor: Colors.black,),
                        SizedBox(height: 10,),
                        Divider(thickness: 1.5,),
                        rowHeadingWidget(FontAwesomeIcons.coins, 'Placements'),
                         Align(
                          alignment: Alignment.centerLeft,
                          child: TextWidget(text: courseData!.data.placement??'', fontFamily: 'Inter',fontSize: 14,fontWeight: FontWeight.w700,color: Color(0xff777AAE),)),
                        SizedBox(height: 10,),
                        Divider(thickness: 1.5,),
                        rowHeadingWidget(FontAwesomeIcons.file, 'Documnets Required'),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextWidget(text: courseData!.data.documentRequired??'', fontFamily: 'Inter',fontSize: 14,fontWeight: FontWeight.w700,color: Color(0xff777AAE),)),
                        CustomButton(text: 'Get Admission', onPressed: (){}, isTextOnly: true, color: Color(0xff141E3C))






                  
                      ],
                    ),
                  ),
                ),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
              ],
            ),
          ),
          
        ],
      )
    );
  }


  universityRow(String text,IconData icon){
    return Row(
        children: [
          Icon(icon,size: 16,),
          SizedBox(width: 10,),
          TextWidget(text: text, fontFamily: 'Inter',fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff777AAE),),
        ],
      );
  }

  courseDetaillistfunc(BuildContext context)async{
  var strUrl = base_url + course_detail_endpoint;
  var headerData = {
        'Authorization': accessToken,
      };

  final params = {
      'id': '25',
      'universityId' : '12'
    };

    try {
       final response = await getMethodApi(strUrl,queryParams: params, header: headerData);
       if (response.statusCode == 200 || response.statusCode == 201) {
          Map<String, dynamic> data = json.decode(response.body);
            courseData = Course.fromJson(data);
            setState(() {
              isLoading = false;
            });

       }else{
        showDialog(context: context, builder: (context) => const AlertDialog(content: Text('Invalid username or password'),));
        setState(() {
              isLoading = false;
            });
       }
    } catch (e) {
      
    }
}
}

Widget mainContent() {
  return Column(

  );
}

topImagesection(BuildContext context) {
  return Stack(
    children: [
      SizedBox(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            'assets/images/course.png',
            fit: BoxFit.cover,
          )),
      Positioned(
          top: 50,
          left: 25,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white),
                  color: Colors.white.withOpacity(0.2)),
              child: Icon(
                Icons.chevron_left,
                size: 40,
                color: Colors.white,
              ),
            ),
          )),
      Positioned(
        top: 50,
        right: 16,
        child: Row(
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white),
                    color: Colors.white),
                child: Icon(
                  FontAwesomeIcons.heart,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white),
                    color: Colors.white),
                child: Icon(
                  FontAwesomeIcons.shareNodes,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    ],
  );
}


