import 'package:flutter/material.dart';
import 'package:flutter_inkflow_app/src/views/create_note.dart';
import 'package:flutter_inkflow_app/src/views/home.dart';
import 'package:flutter_inkflow_app/src/views/login_screen.dart';
import 'package:flutter_inkflow_app/src/views/register_screen.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeView.routeName:
        return HomeView.route();
      case CreateNoteView.routeName:
        return CreateNoteView.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case RegisterScreen.routeName:
        return RegisterScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Something went wrong!'),
        ),
      ),
    );
  }
}
