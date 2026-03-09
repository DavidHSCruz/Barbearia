import 'package:flutter/material.dart';

sealed class AppColors {
  static const Color primary = Color(0xFFD4AF37); // Gold
  static const Color secondary = Color(0xFF2C3E50); // Dark Blue
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFF1A1A1A);
  static const Color textPrimary = Color(0xFF333333);

  // High Contrast & Accessibility
  static const Color error = Color(0xFFB00020);
  static const Color success = Color(
    0xFF2E7D32,
  ); // Dark Green for better contrast on light
  static const Color warning = Color(0xFFF57F17); // Dark Orange

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF5F5F5);
  static const Color lightText = Color(0xFF1C1B1F); // High contrast black
  static const Color lightOnSurface = Color(0xFF1C1B1F);
  static const Color lightPrimaryContainer = Color(
    0xFFFFE082,
  ); // Lighter gold for containers
  static const Color lightOnPrimaryContainer = Color(
    0xFF2C3E50,
  ); // Dark text on light gold

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkText = Color(0xFFE6E1E5); // High contrast white
  static const Color darkOnSurface = Color(0xFFE6E1E5);
  static const Color darkPrimaryContainer = Color(
    0xFF4A3B00,
  ); // Darker gold for containers
  static const Color darkOnPrimaryContainer = Color(
    0xFFFFE082,
  ); // Light text on dark gold
}
