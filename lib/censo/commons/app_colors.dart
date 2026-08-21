import 'package:flutter/material.dart';

abstract class AppColors {
  // --- Marca & Destaques Primários ---
  static const Color primary = Color(0xFF1E3A8A);
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color primaryDark = Color(0xFF172554);
  static const Color secondary = Color(0xFF0D9488); 

  // --- Superfícies e Fundos ---
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);

  // --- Tipografia / Textos ---
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // --- Bordas e Divisores ---
  static const Color border = Color(0xFFE2E8F0);
  static const Color divider = Color(0xFFCBD5E1);

  // --- Status & Feedback ---
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFD97706);
  static const Color error = Color(0xFFDC2626);
  static const Color info = Color(0xFF0284C7);

  // Pódio / Rankings
  static const Color gold = Color(0xFFD97706);
  static const Color goldBackground = Color(0xFFFEF3C7);

  static const Color silver = Color(0xFF475569);
  static const Color silverBackground = Color(0xFFE2E8F0);

  static const Color bronze = Color(0xFFB45309);
  static const Color bronzeBackground = Color(0xFFFFEDD5);

  static const Color rankDefault = Color(0xFF64748B);
  static const Color rankDefaultBackground = Color(0xFFF1F5F9);
}