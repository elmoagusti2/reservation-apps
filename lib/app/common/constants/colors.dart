import 'package:flutter/material.dart';

class ConstColors {
  static const white = Color(0xFFFFFFFF);
  static const dark40 = Color(0xFF757575);
  static const dark50 = Color(0xFF333333);
  static const gray10 = Color(0xFFFAFAFA);
  static const gray20 = Color(0xFFF2F2F2);
  static const gray30 = Color(0xFFE8E8E8);
  static const gray40 = Color(0xFFE0E0E0);
  static const orange10 = Color(0xFFFFF3EF);
  static const orange20 = Color(0xFFFFE3DA);
  static const orange30 = Color(0xFFFFB094);
  static const orange40 = Color(0xFFFA622D);
  static const orange50 = Color(0xFFBB4217);
  static const yellow10 = Color(0xFFFFF5E8);
  static const yellow20 = Color(0xFFFFEACC);
  static const yellow30 = Color(0xFFFEBA57);
  static const yellow40 = Color(0xFFFF9700);
  static const yellow50 = Color(0xFFB6833A);
  static const red10 = Color(0xFFFFEEEE);
  static const red20 = Color(0xFFFFC4C4);
  static const red30 = Color(0xFFFF6060);
  static const red40 = Color(0xFFEF3030);
  static const red50 = Color(0xFF9A1919);
  static const green10 = Color(0xFFD1F7C4);
  static const green20 = Color(0xFF93E088);
  static const green30 = Color(0xFF20C933);
  static const green40 = Color(0xFF11AF22);
  static const green50 = Color(0xFF338A17);
  static const blue10 = Color(0xFFCFDFFF);
  static const blue20 = Color(0xFF9CC7FF);
  static const blue30 = Color(0xFF2D7FF9);
  static const blue40 = Color(0xFF1283DA);
  static const blue50 = Color(0xFF2750AE);
  static const teal10 = Color(0xFFC2F5E9);
  static const teal20 = Color(0xFF72DDC3);
  static const teal30 = Color(0xFF20D9D2);
  static const teal40 = Color(0xFF02AAA4);
  static const teal50 = Color(0xFF06A09B);
  static const purple10 = Color(0xFFF1F2FF);
  static const purple20 = Color(0xFFCED0FF);
  static const purple30 = Color(0xFF9BA0FF);
  static const purple40 = Color(0xFF787EFF);
  static const purple50 = Color(0xFF5F64C0);
  static const pink10 = Color(0xFFFFE0E6);
  static const pink20 = Color(0xFFFF95A8);
  static const pink30 = Color(0xFFE94D69);
  static const pink40 = Color(0xFFD51B3D);
  static const pink50 = Color(0xFFB90022);
  static const darkBlue10 = Color(0xFFE5F0F7);
  static const darkBlue20 = Color(0xFFC4D8E3);
  static const darkBlue30 = Color(0xFF95B8CB);
  static const darkBlue40 = Color(0xFF588096);
  static const darkBlue50 = Color(0xFF174A66);

  static const coverCompany08 = Color(0xFFA12971);
  static const coverCompany07 = Color(0XFF7329A1);
  static const coverCompany06 = Color(0XFF2959A1);
  static const coverCompany05 = Color(0XFF2976A1);
  static const coverCompany04 = Color(0XFFA13F29);
  static const coverCompany03 = Color(0XFFA19529);
  static const coverCompany02 = Color(0XFF6CA129);
  static const coverCompany01 = Color(0XFF29A184);

  static Color iSolution50 = fromHexString('#1B70A8');
  static Color iSolution40 = fromHexString('#F39F4F');
  static Color iSolution30 = fromHexString('#B3D35C');
  static const customRed = Color(0xFF960059);
  static const customRed20 = Color.fromARGB(255, 220, 159, 196);

  static Color custom = fromHexString("#960059");

  // unavailable gray in Figma's library
  static const graySoft = Color(0xFF959595);
  static const grayMedium = Color(0xFF858585);
  static const grayDark = Color(0xFF676767);
  static const grayStar = Color(0XFFF3E2E2);
  static const grayF9 = Color(0XFFF9F9F9);
  static const grayBattleship = Color(0xff818181);
  static const grayLavender = Color(0xffC5C7D0);

  // unavailable white in Figma's library
  static const whiteGhost = Color(0xFFF6F9FF);

  // unavailable orange in Figma's library
  static const cream = Color(0XFFFEE9EA);
  static const orangePastel = Color(0xFFFF9254);

  // unavailable red in Figma's library
  static const redBlush = Color(0xFFEA6585);

  // unavailable cream in Figma's library
  static const blueCrystal = Color(0xFF6AAAF4);
  static const blueNavy = Color(0xFF5E99C4);
  static const bluesoft = Color(0xffD0F0FD);

  // unavailable blue in Figma's library
  static const cyan40 = Color(0xFF01A9DB);

  static Color fromHexString(String? hexString) {
    if (hexString != null) {
      return Color(
          int.parse(hexString.substring(1, 7), radix: 16) + 0xFF000000);
    }
    return Colors.transparent;
  }

  static String toHexString(Color? color) {
    Color translatedColor = color ?? Colors.transparent;
    return '#${translatedColor.value.toRadixString(16).split('ff')[1]}';
  }
}
