import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';



var kcTitleStyle = GoogleFonts.poppins(
  color: Colors.black,
  fontSize: 17.sp,
  fontWeight: FontWeight.w400,
);

var kcTitleStyleBold = GoogleFonts.poppins(
  color: Colors.black,
  fontSize: 18.sp,
  fontWeight: FontWeight.w600,
);

var kcTitleWhiteStyle = GoogleFonts.poppins(
  color: Colors.white,
  fontWeight: FontWeight.w500,
  fontSize: 18.sp,
);

var kcTitleWhiteStyleBold = GoogleFonts.poppins(
  color: Colors.white,
  fontWeight: FontWeight.w600,
  fontSize: 18.sp,
);

// Display Text Styles

final TextStyle kcDisplayStyle = GoogleFonts.poppins(
  color: Colors.black,
  fontSize: 20.sp,
  fontWeight: FontWeight.w400,
);

final TextStyle kcDisplayWhiteStyle =
    kcDisplayStyle.copyWith(color: Colors.white);

final TextStyle kcDisplayBoldStyle = GoogleFonts.poppins(
  color: Colors.black,
  fontSize: 20.sp,
  fontWeight: FontWeight.bold,
);

final TextStyle kcDisplayBoldWhiteStyle =
    kcDisplayBoldStyle.copyWith(color: Colors.white);




final TextStyle kcTitleBoldStyle =
    kcTitleStyle.copyWith(fontWeight: FontWeight.bold);

final TextStyle kcTitleBoldWhiteStyle =
    kcTitleBoldStyle.copyWith(color: Colors.white);

/// Subtitle Text Styles

final TextStyle kcSubtitleStyle = GoogleFonts.poppins(
  color: Colors.black,
  fontSize: 16.sp,
  fontWeight: FontWeight.w400,
);

final TextStyle kcSubtitleWhiteStyle =
    kcSubtitleStyle.copyWith(color: Colors.white);

final TextStyle kcSubtitleBoldStyle =
    kcSubtitleStyle.copyWith(fontWeight: FontWeight.bold);

final TextStyle kcSubtitleBoldWhiteStyle =
    kcSubtitleBoldStyle.copyWith(color: Colors.white);

/// Body Text Styles

final TextStyle kcBodyStyle = GoogleFonts.poppins(
  color: Colors.black,
  fontWeight: FontWeight.w400,
  fontSize: 15.sp,
);

final TextStyle kcBodyWhiteStyle = kcBodyStyle.copyWith(color: Colors.white);

final TextStyle kcBodyBoldStyle =
    kcBodyStyle.copyWith(fontWeight: FontWeight.bold);

final TextStyle kcBodyBoldWhiteStyle =
    kcBodyBoldStyle.copyWith(color: Colors.white);

// Caption Text Styles

final TextStyle kcCaptionStyle = GoogleFonts.poppins(
  color: Colors.black,
  fontSize: 13.sp,
  fontWeight: FontWeight.w400,
);

final TextStyle kcCaptionWhiteStyle =
    kcCaptionStyle.copyWith(color: Colors.white);

final TextStyle kcCaptionBoldStyle =
    kcCaptionStyle.copyWith(fontWeight: FontWeight.bold);

final TextStyle kcCaptionBoldWhiteStyle =
    kcCaptionBoldStyle.copyWith(color: Colors.white);