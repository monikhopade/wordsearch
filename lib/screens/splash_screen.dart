import 'package:flutter/material.dart';

import '../route/route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

late AnimationController _controller;
  late Animation<Offset> _animation1;
late AnimationController _controller2;
  late Animation<Offset> _animation2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
     _animation1 = Tween<Offset>(
      begin: const Offset(-1.0, -1.0),  
      end: const Offset(0.0, 0.0),     
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceIn,  
    ));

    _controller2 = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

     _animation2 = Tween<Offset>(
      begin: const Offset(1.0, 1.0),  
      end: const Offset(0.0, 0.0),     
    ).animate(CurvedAnimation(
      parent: _controller2,
      curve: Curves.bounceIn,  
    ));
    _controller.forward();
    _controller2.forward();

     Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.wordScreen);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                 Color(0xFF3366FF),
                 Color(0xFFFFFFFF),
                ],
                begin: Alignment.topLeft, 
                end: Alignment.bottomRight,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(right: 80.0,bottom: 80),
                  child: SlideTransition(
                    position: _animation1,
                    child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: const Text(
                      'Word',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(left: 80.0,top: 80),
                  child: SlideTransition(
                    position: _animation2,
                    child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.green,
                    alignment: Alignment.center,
                    child: const Text(
                      'Search',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}