// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final String fontFamily;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;

  const TextWidget({super.key, 
    required this.text,
    this.fontSize,
    required this.fontFamily,
    this.fontWeight,
    this.fontStyle,
    this.decoration, this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.getFont(
        fontFamily,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }
}

class CurvedTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String hintText;
  // final IconData icon;

  CurvedTextField({
    required this.controller,
    required this.obscureText,
    required this.hintText,
    // required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            color: Color(0xffBDBEDC),
            fontSize: 14,
            fontWeight : FontWeight.w400,
          ),
          filled: true,
          fillColor: Colors.white, // Your custom color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22.0),
            borderSide: BorderSide(color: Color(0xffBDBEDC)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22.0), 
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22.0), 
            borderSide: const BorderSide(color: Color(0xffBDBEDC)),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? textSize;
  final bool isTextOnly;
  final Color color;
  final bool? isBorder;

  CustomButton({
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
          borderRadius: BorderRadius.circular(18.0),
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
                    color: textColor ?? Colors.white,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/google_icon.png',height: 24,width: 24,),
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