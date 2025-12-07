import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iism_2025/widgets/animated_pattern_bg.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 800,
          child: Stack(children: [
                      Positioned(
                        top: -10,
                        left: 13,
                        child: Opacity(opacity:0.4 ,
                          child: Image.asset(
                                  'assets/legacy-mobile.webp',
                                  height: 500,
                                  width: 360,
                                  // color: Colors.white,
                                ),
                        )
                      ),
                      Positioned(
                          top: 200,
                          left: 138,
                          child: SvgPicture.asset(
                                    'assets/logo-no-text.svg',
                                    height: 100,
                                    width: 150,
                                    color: Colors.white,
                                  )
                        ),
                       
                        Positioned(
                          top: 420, // 🔥 push BELOW BLUE
                          left: -40,
                          right: -40,
                          child: Transform.rotate(
                            angle: -0.05, // tilt correctly
                            child: Container(
                              height: 20,
                              color: const Color(0xFFFF9F1C),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 430,
                          width: 360,
                          child: SizedBox(
                            width: 360,
                            child: Stack(
                              children: [
                                

                                Container(
                                  padding: const EdgeInsets.all(24),
                                  color: const Color(0xFF1F3BB2),
                                  width: 360,

                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      

                                      const SizedBox(height: 16),

                                      SizedBox(
                                        height: 300,
                                      ),
                                    ],
                                  ),
                                ),
                                const Positioned.fill(
                                  left :0,
                                  top : 172,
                                  child: AnimatedPatternBackground(animated: false),
                                ),
                                Positioned(
                                  top :130,
                                  left : 125,
                                  child: Transform(
                                        transform: Matrix4.skewX(-0.25),   // 🔶 button skew (left tilt)
                                        child: SizedBox(
                                          width: 120,
                                          height: 50,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color(0xFFFF8A00),
                                              foregroundColor: Colors.white,
                                              shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.zero, // ⛔ no rounding
                                              ),
                                              elevation: 4,
                                              padding: EdgeInsets.zero,
                                            ),
                                            onPressed: () {
                                              context.replace('/logindetails');
                                            },
                                            child: Transform(
                                              transform: Matrix4.skewX(0.25),   // 🔷 opposite skew for text
                                              alignment: Alignment.center,
                                              child: const Text(
                                                "LOGIN",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      ),
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
        )
      ],
    );
  }
}
