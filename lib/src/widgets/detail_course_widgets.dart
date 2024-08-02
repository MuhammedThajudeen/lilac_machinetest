
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lilac_test/src/widgets/login_common_widgets.dart';

roundContainer(String text,double? width){
  return Container(
    height: 60,
    // width: width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: Color(0xffF6F6F6),
    ),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: TextWidget(text: text, fontFamily: 'Inter',fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff0E0106),),
      ))
  );
}

rowHeadingWidget(IconData icon,String text){
  return Column(
    children: [
      SizedBox(height: 20,),
      Row(
            children: [
              Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                  
                ),
                child: Icon(icon,color: Colors.white,size: 14,),
              ),
              SizedBox(width: 10,),
              TextWidget(text: text, fontFamily: 'Inter',fontSize: 16,fontWeight: FontWeight.w700,color: Color(0xff141E3C),),
            ]),
      SizedBox(height: 20,),
    ],
  );
}

class CustomButtonDownload extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? textSize;
  final bool isTextOnly;
  final Color color;
  final bool? isBorder;

  CustomButtonDownload({
    required this.onPressed,
    this.text = '',
    this.textColor,
    this.fontWeight,
    this.textSize,
    required this.isTextOnly,
    required this.color, this.isBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 56,
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: color, // Button background color
          borderRadius: BorderRadius.circular(25.0),
          border: isBorder == true ? Border.all(color: Color(0xffBDBEDC)) : null,
        ),
        child: Center(
          child: isTextOnly
              ? Text(
                  text,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: textSize ?? 16.0,
                    fontWeight: fontWeight ?? FontWeight.w700,
                    color: textColor ?? Colors.black,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xffBDBEDC),
                      foregroundColor: Colors.white,
                      child: Icon(FontAwesomeIcons.download,size: 14,),
                    ),
                    Text(
                      text,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: textSize ?? 14.0,
                        fontWeight: fontWeight ?? FontWeight.w700,
                        color: textColor ?? Colors.white,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}