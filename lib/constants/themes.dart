import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class Themes {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.whiteBackgroundColor,
    appBarTheme: AppBarTheme(
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.lightBottomNavColor,
      ),
      backgroundColor: AppColors.lightAppBarColor,
      titleTextStyle: GoogleFonts.poppins(
        textStyle: const TextStyle(
          color: AppColors.lightAppBarTitleColor,
          fontSize: 32,
          fontWeight: FontWeight.w700,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightBottomNavColor,
      selectedItemColor: AppColors.lightBottomNavTabColor,
      unselectedItemColor: AppColors.lightBottomNavSelectedIconColor,
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      bodyLarge: GoogleFonts.poppins(
        textStyle: const TextStyle(color: Colors.black),
      ),
      bodySmall: GoogleFonts.poppins(
        textStyle: const TextStyle(color: AppColors.lightTextColor),
      ),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
    useMaterial3: true,
    cardTheme: CardTheme(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.grey.withOpacity(0.2),
    ),
    iconTheme: const IconThemeData(color: AppColors.lightIconColor),
    switchTheme: SwitchThemeData(
      trackOutlineColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return const Color(0xff6dec83);
          }
          return Colors.black;
        },
      ),
      thumbColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.white;
          }
          return Colors.black;
        },
      ),
      trackColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return const Color(0xff6dec83);
          }
          return Colors.white;
        },
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.blackBackgroundColor,
    appBarTheme: AppBarTheme(
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppColors.darkBottomNavColor),
      backgroundColor: AppColors.darkAppBarColor,
      titleTextStyle: GoogleFonts.poppins(
        textStyle: const TextStyle(
          color: AppColors.darkAppBarTitleColor,
          fontSize: 32,
          fontWeight: FontWeight.w700,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkBottomNavColor,
      selectedItemColor: AppColors.darkBottomNavTabColor,
      unselectedItemColor: AppColors.darkBottomNavSelectedIconColor,
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      bodyLarge: GoogleFonts.poppins(
        textStyle: const TextStyle(color: Colors.white),
      ),
      bodySmall: GoogleFonts.poppins(
        textStyle: const TextStyle(color: AppColors.darkTextColor),
      ),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
    useMaterial3: true,
    cardTheme: const CardTheme(
      color: Colors.white10,
      surfaceTintColor: Colors.white10,
      shadowColor: Colors.transparent,
    ),
    iconTheme: const IconThemeData(color: AppColors.darkIconColor),
    switchTheme: SwitchThemeData(
      trackOutlineColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return const Color(0xff6dec83);
          }
          return Colors.white;
        },
      ),
      thumbColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.black;
          }
          return Colors.white;
        },
      ),
      trackColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return const Color(0xff6dec83);
          }
          return Colors.black;
        },
      ),
    ),
  );
}
