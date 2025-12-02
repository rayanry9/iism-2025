import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iism_2025/widgets/animated_pattern_bg.dart';

// import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Schedule navigation after first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 4));
      if (!mounted) return;

      context.replace('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body:Stack(
        children: [
          Stack(
            children: [
              Container(
                height: 1000,       // your REALLY LARGE container
                width: double.infinity,
                color: const Color(0xFF283891),
              ),
              Positioned.fill(
                child: AnimatedPatternBackground(),
              ),
              Positioned(
                top: 330,
                left: 138,
                child: SvgPicture.asset(
                          'assets/logo-no-text.svg',
                          height: 100,
                          width: 150,
                          color: Colors.white,
                        )
              )
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: 60,
                child:Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: 40, // 🔥 push BELOW BLUE
                      left: -40,
                      right: -40,
                      child: Transform.rotate(
                        angle: -0.1, // tilt correctly
                        child: Container(
                          height: 40,
                          color: const Color(0xFFFF9F1C),
                        ),
                      ),
                    ),

                    Positioned.fill(
                      top: -80,
                      left:-10,
                      child: Transform.rotate(
                        angle: -0.05, // adjust tilt here 🔥
                        child: Container(
                          color: Color(0xff191C2A),
                        ),
                      ),
                    ),
                  ]
                ),
              ),
              SizedBox(height: 300,),
              Spacer(),
              SizedBox(
                height: 100,
                // width: 2000,
                child:Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: 0, // 🔥 push BELOW BLUE
                      left: -40,
                      right: -40,
                      child: Transform.rotate(
                        angle: -0.1, // tilt correctly
                        child: Container(
                          height: 40,
                          color: const Color(0xFFFF9F1C),
                        ),
                      ),
                    ),

                    Positioned.fill(
                      top: 20,
                      left:-10,
                      child: Transform.rotate(
                        angle: -0.05, // adjust tilt here 🔥
                        child: Container(
                          color: Color(0xff191C2A),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      top: 50,
                      left:-10,
                      child: Transform.rotate(
                        angle: -0.0, // adjust tilt here 🔥
                        child: Container(
                          color: Color(0xff191C2A),
                        ),
                      ),
                    ),
                  ]
                ),
              ),
            ],
          ),
          
        ],
      )
    );
  }
}

