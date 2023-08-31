import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inkflow_app/firebase_options.dart';
import 'package:flutter_inkflow_app/src/res/helper_functions.dart';
import 'package:flutter_inkflow_app/src/res/strings.dart';
import 'package:flutter_inkflow_app/src/routes/app_routes.dart';
import 'package:flutter_inkflow_app/src/views/home.dart';
import 'package:flutter_inkflow_app/src/views/login_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await loadFonts();
  runApp(
    const MyApp(),
  );
}

Future<void> loadFonts() async {
  final fontLoader = FontLoader('Poppins');
  fontLoader.addFont(
    rootBundle.load('assets/fonts/Poppins-Black.ttf'),
  );
  fontLoader.addFont(
    rootBundle.load('assets/fonts/Poppins-ExtraBold.ttf'),
  );
  fontLoader.addFont(
    rootBundle.load('assets/fonts/Poppins-ExtraLight.ttf'),
  );
  fontLoader.addFont(
    rootBundle.load('assets/fonts/Poppins-SemiBold.ttf'),
  );
  await fontLoader.load();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;
  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  Future<void> getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, child) => MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        home: _isSignedIn ? const HomeView() : const LoginScreen(),
        theme: lightTheme(),
        darkTheme: darkTheme(),
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
