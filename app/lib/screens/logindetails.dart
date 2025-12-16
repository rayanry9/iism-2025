import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iism_2025/constants/colors.dart';
import 'package:iism_2025/constants/constants.dart';
import 'package:iism_2025/services/api_service.dart';
import 'package:iism_2025/services/auth.dart';
import 'package:provider/provider.dart';

class LogindetailsScreen extends StatefulWidget {
  final ApiService apiService;
  final AuthStatus authStatus;
  const LogindetailsScreen({
    super.key,
    required this.apiService,
    required this.authStatus,
  });

  @override
  State<LogindetailsScreen> createState() => _LogindetailsScreenState();
}

class _LogindetailsScreenState extends State<LogindetailsScreen> {
  bool _obscure = true;
  bool _requested = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void onLoginPressed() async {
    final success = await widget.apiService.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    print("uyiyiyyiuyui");
    print(success);
    if (success) {
      print("adfadfs");
      await widget.authStatus.checkLoginState();
    }
    print("nm,n,mnm,nnm,");
    setState(() {
      _requested = false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
                        "Registered Email/Id",
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
                        onPressed: () {
                          if (!_requested) {
                            onLoginPressed();
                          }
                          setState(() {
                            _requested = true;
                          });
                        },
                        child: Transform(
                          transform: Matrix4.skewX(Constants.skewXValue),
                          alignment: Alignment.center,
                          child: _requested
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
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
