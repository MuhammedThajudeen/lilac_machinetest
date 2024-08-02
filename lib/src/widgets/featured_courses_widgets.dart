// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lilac_test/src/widgets/login_common_widgets.dart';

class CustomCard extends StatelessWidget {
  final String imageUrl;
  final String smallText;
  final String detailText;

  CustomCard({
    required this.imageUrl,
    required this.smallText,
    required this.detailText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                child: Image.network(
                  imageUrl,
                  height: 130, // Adjust the height as needed
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: containerTag('Beginner',FontAwesomeIcons.locationPin),),
              Positioned(
              bottom: 10,
              right: 10,
              child: containerTag('Beginner',FontAwesomeIcons.indianRupeeSign),)
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(FontAwesomeIcons.buildingColumns,size: 16,),
                    SizedBox(width: 5,),
                    Text(
                      smallText,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.0),
                Text(
                  detailText,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

containerTag(String text,IconData icon) {
  return Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(50)
            ),
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Icon(icon,color: Colors.white,size: 12,),
                SizedBox(width: 5,),
                TextWidget(text: text, fontFamily: 'Inter',fontSize: 8,fontWeight: FontWeight.w400,color: Colors.black,)
              ],
            ) 
        );
} 