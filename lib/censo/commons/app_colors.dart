import 'package:flutter/material.dart';

abstract class AppColors {
  // --- Marca & Destaques Primários ---
  static const Color primary = Color(0xFF1E3A8A); // Azul escuro moderno
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color primaryDark = Color(0xFF172554);
  static const Color secondary = Color(0xFF0D9488); // Teal elegante

  // --- Superfícies e Fundos ---
  static const Color background = Color(0xFFF8FAFC); // Cinza bem sutil (clean)
  static const Color surface = Color(0xFFFFFFFF); // Branco puro para Cards
  static const Color surfaceVariant = Color(0xFFF1F5F9);

  // --- Tipografia / Textos ---
  static const Color textPrimary = Color(0xFF0F172A); // Quase preto (alto contraste)
  static const Color textSecondary = Color(0xFF64748B); // Cinza intermediário
  static const Color textMuted = Color(0xFF94A3B8); // Cinza claro para legendas
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // --- Bordas e Divisores ---
  static const Color border = Color(0xFFE2E8F0);
  static const Color divider = Color(0xFFCBD5E1);

  // --- Status & Feedback ---
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFD97706);
  static const Color error = Color(0xFFDC2626);
  static const Color info = Color(0xFF0284C7);

  // --- Ranking / Pódios (Opcional, ótimo para nomes mais frequentes) ---
  static const Color gold = Color(0xFFF59E0B);
  static const Color silver = Color(0xFF94A3B8);
  static const Color bronze = Color(0xFFB45309);
}