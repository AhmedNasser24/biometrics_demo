import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';

class AppTextStyles {
  static TextStyle get bold32PrimaryDark => GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppTheme.primaryDark,
  );

  static TextStyle get bold24PrimaryDark => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppTheme.primaryDark,
  );

  static TextStyle get semiBold20PrimaryDark => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppTheme.primaryDark,
  );

  static TextStyle get medium18PrimaryDark => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppTheme.primaryDark,
  );

  static TextStyle get regular16black87 => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
  );

  static TextStyle get regular14black87 => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
  );

  static TextStyle get semiBold16White => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle get regular14Red => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.red,
  );
}
