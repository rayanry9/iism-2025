import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iism_2025/constants/colors.dart';
import 'package:iism_2025/constants/constants.dart';

final dio = Dio();
final cookieJar = CookieJar(); // stores cookies in memory

void setupDio() {
  dio.interceptors.add(CookieManager(cookieJar));
}

class LogindetailsScreen extends StatefulWidget {
  const LogindetailsScreen({super.key});

  @override
  State<LogindetailsScreen> createState() => _LogindetailsScreenState();
}

class _LogindetailsScreenState extends State<LogindetailsScreen> {
  bool _obscure = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String apiUrl = dotenv.env['API_URL']!;
  Future<bool> login(String email, String password) async {
    try {
      final response = await dio.post(
        apiUrl + "/api/login",
        data: {"email": email, "password": password},
      );
      List<Cookie> cookies = await cookieJar.loadForRequest(
        Uri.parse(dotenv.env['API_URL']!),
      );
      print("test");
      for (var cookie in cookies) {
        print("${cookie.name} = ${cookie.value}");
      }
      return response.statusCode == 200;
    } on DioException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  void onLoginPressed() async {
    bool success = await login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (success) {
      context.replace('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Material(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Constants.screenWidthPadding,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "LOGIN",
                        style: TextStyle(
                          fontSize: Constants.heading2TextSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 32),
                      Text(
                        "Registered Email",
                        style: TextStyle(
                          fontSize: Constants.titlesTextSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: InputBorder.none,
                          hintText: "Enter here",
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        "Password",
                        style: TextStyle(
                          fontSize: Constants.titlesTextSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12),
                      TextField(
                        obscureText: _obscure,
                        controller: passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: InputBorder.none,
                          hintText: "Enter here",
                          suffixIcon: IconButton(
                            icon: Icon(
                              !_obscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscure = !_obscure; // toggle
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.skewX(-Constants.skewXValue),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.orange,
                          foregroundColor: Colors.white,
                          padding: EdgeInsetsGeometry.symmetric(
                            horizontal: 42,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: onLoginPressed,
                        child: Transform(
                          transform: Matrix4.skewX(Constants.skewXValue),
                          alignment: Alignment.center,
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                              fontSize: Constants.buttonTextSize,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ClipPath(
          clipper: _ClipperYellow(),
          child: Container(color: CustomColors.yellow),
        ),
        ClipPath(
          clipper: _ClipperBlue(),
          child: Container(color: CustomColors.darkBlue),
        ),
      ],
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     body: SingleChildScrollView(
  //       child: Center(
  //         child: Padding(
  //           padding: EdgeInsets.all(20),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               SizedBox(height: 150),
  //               Container(
  //                 alignment: Alignment.centerLeft,
  //                 child: Text(
  //                   "LOGIN",
  //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //               SizedBox(height: 30),
  //               Container(
  //                 alignment: Alignment.centerLeft,
  //                 child: Text(
  //                   "Registered Email",
  //                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //               SizedBox(height: 5),
  //               SizedBox(
  //                 height: 45,
  //                 child: TextField(
  //                   controller: emailController,
  //                   decoration: InputDecoration(
  //                     filled: true,
  //                     fillColor: Colors.grey[200],
  //                     border: InputBorder.none,
  //                     hintText: "Enter here",
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 30),
  //               Container(
  //                 alignment: Alignment.centerLeft,
  //                 child: Text(
  //                   "Password",
  //                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //               SizedBox(height: 5),
  //               SizedBox(
  //                 height: 45,
  //                 child: TextField(
  //                   obscureText: _obscure,
  //                   controller: passwordController,
  //                   decoration: InputDecoration(
  //                     filled: true,
  //                     fillColor: Colors.grey[200],
  //                     border: InputBorder.none,
  //                     hintText: "Enter here",
  //                     suffixIcon: IconButton(
  //                       icon: Icon(
  //                         !_obscure ? Icons.visibility_off : Icons.visibility,
  //                       ),
  //                       onPressed: () {
  //                         setState(() {
  //                           _obscure = !_obscure; // toggle
  //                         });
  //                       },
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 150),
  //               Transform(
  //                 transform: Matrix4.skewX(-0.3),
  //                 child: Container(
  //                   height: 50,
  //                   width: 150,
  //                   color: Colors.orange,
  //                   child: ElevatedButton(
  //                     onPressed: onLoginPressed,
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: Color(0xFFEF4823),
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius:
  //                             BorderRadius.zero, // ← makes it a rectangle
  //                       ),
  //                     ),
  //                     child: Center(
  //                       child: Transform(
  //                         transform: Matrix4.skewX(0.3),
  //                         child: Text(
  //                           "NEXT",
  //                           style: TextStyle(fontSize: 18, color: Colors.white),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

class _ClipperYellow extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.05);
    path.lineTo(0, size.height * 0.01);
    path.close();

    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.99);
    path.lineTo(0, size.height * 0.95);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class _ClipperBlue extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.05);
    path.lineTo(size.width, size.height * 0.03);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.95);
    path.lineTo(0, size.height * 0.98);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
