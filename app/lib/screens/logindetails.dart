import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
final dio = Dio();
final cookieJar = CookieJar();   // stores cookies in memory



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
  String apiUrl = dotenv.env['API_URL']! ?? "http://localhost:8173";
  Future<bool> login(String email, String password) async {
  try {
    final response = await dio.post(
      apiUrl+"/api/login",
      data: {
        "email": email,
        "password": password,
      },
    );
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
        child:Padding(padding: EdgeInsets.all(20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 150,),
              Container(
                alignment: Alignment.centerLeft,
                child:  Text("LOGIN",
                          style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          ),),
              ),
              SizedBox(height: 30),
              Container(
                alignment: Alignment.centerLeft,
                child: Text("Registered Email",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 5),
              SizedBox(
                height: 45,
                child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: InputBorder.none,
                    hintText: "Enter here",
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                alignment: Alignment.centerLeft,
                child: Text("Password",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 5),
              SizedBox(
                height: 45,
                child: TextField(
                    obscureText: _obscure,
                    controller: passwordController,
                    decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: InputBorder.none,
                    hintText: "Enter here",
                    suffixIcon: IconButton(
                      icon: Icon(
                        !_obscure ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscure = !_obscure; // toggle
                        });
                      },
                    ),
                  ),
                  
                ),
              ),
              SizedBox(height: 150),
             Transform(
              transform: Matrix4.skewX(-0.3),
              child: Container(
                height: 50,
                width: 150,
                color: Colors.orange,
                child: ElevatedButton(
                        onPressed:onLoginPressed,
                        style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFEF4823),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,   // ← makes it a rectangle
                                ),
                        ),
                        child: Center(child: Transform(
                          transform: Matrix4.skewX(0.3),
                          child: Text("NEXT",style: TextStyle(fontSize: 18,color: Colors.white)),
                        ),)
                      ) ,
                )
             )
            ],
          ) 
        )
      ),
      )
    );
  }
}
