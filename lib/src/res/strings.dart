import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStrings {
  static const appName = 'InkFlow';
}

void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 4),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
        textColor: Colors.white,
      ),
    ),
  );
}

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
      },
    ),
    colorScheme: ThemeData.light().colorScheme.copyWith(
          primary: Colors.white,
          onPrimary: Colors.black,
          secondary: Colors.grey[100],
          onSecondary: Colors.black,
        ),
    textTheme: TextTheme(
      titleMedium: TextStyle(
        color: Colors.black,
        fontFamily: "Poppins",
        fontSize: 24.sp,
        fontWeight: FontWeight.w800,
      ),
      titleSmall: TextStyle(
        color: Colors.black,
        fontFamily: "Poppins",
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontFamily: "Poppins",
        fontSize: 18.sp,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        color: Colors.black,
        fontFamily: "Poppins",
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    drawerTheme: const DrawerThemeData(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent),
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontFamily: "Poppins",
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
      ),
      centerTitle: true,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
    colorScheme: ThemeData.dark().colorScheme.copyWith(
          primary: Colors.white,
          onPrimary: Colors.white,
          secondary: Colors.grey[900],
          onSecondary: Colors.white,
        ),
    textTheme: TextTheme(
      titleMedium: TextStyle(
        color: Colors.white,
        fontFamily: "Poppins",
        fontSize: 24.sp,
        fontWeight: FontWeight.w800,
      ),
      titleSmall: TextStyle(
        color: Colors.white,
        fontFamily: "Poppins",
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontFamily: "Poppins",
        fontSize: 18.sp,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        color: Colors.white,
        fontFamily: "Poppins",
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
      ),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.black,
      shadowColor: Colors.grey.shade300,
      surfaceTintColor: Colors.transparent,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontFamily: "Poppins",
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
      ),
      centerTitle: true,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.black,
  );
}
