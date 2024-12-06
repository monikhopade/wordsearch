import 'package:flutter/material.dart';
import 'package:wordsearch/screens/edit_grid_screen.dart';
import 'package:wordsearch/screens/splash_screen.dart';
import 'package:wordsearch/screens/word_screen.dart';

class Routes {
  static const String splashScreen = '/';
  static const String wordScreen = '/wordScreen';
  static const String editGridScreen = '/editGridScreen';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case wordScreen:
        return _createSlideTransition( WordScreen());
      case editGridScreen:
        return _createSlideTransition(EditGridScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  static PageRouteBuilder _createSlideTransition(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(-1.0, 0.0); 
      var end = const Offset(0.0, 0.0);
      var curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}

}
