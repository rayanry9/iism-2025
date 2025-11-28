import 'package:flutter/material.dart';
import 'package:iism_2025/widgets/dynamic_bar.dart';
import 'package:dio/dio.dart';
import 'package:iism_2025/screens/logindetails.dart'; 
import 'package:iism_2025/services/user_cache.dart';
import 'package:go_router/go_router.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  final String route;

   TopBar({super.key, required this.route});

  @override
  State<TopBar> createState() => _TopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// --------------------------------------------------------
// 🔥 This MUST be outside TopBar class
// --------------------------------------------------------
class _TopBarState extends State<TopBar> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    // 1. If cached → skip API
    if (UserCache().hasData) {
      loading = false;
      setState(() {});
      return;
    }

    try {
      // 2. Load cookie from cookieJar
      final uri = Uri.parse("http://192.168.1.17:8173");
      final cookies = await cookieJar.loadForRequest(uri);

      String cookieHeader = cookies.map((c) => "${c.name}=${c.value}").join("; ");

      // 3. API call with Cookie header
      final response = await dio.get(
        "http://192.168.1.17:8173/api/me",
        options: Options(
          headers: {"Cookie": cookieHeader},
        ),
      );

      UserCache().name = response.data["firstName"];
      UserCache().email = response.data["email"];
      UserCache().avatar = response.data["profilePic"];

      loading = false;
      setState(() {});
    } catch (e) {
      loading = false;
      setState(() {});
      print("User API error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DynamicNavbar(
      background: const Color(0xFF191C2A),
      left: _buildLeft(widget.route),
      center: _buildCenter(widget.route),
      right: _buildRight(widget.route),
    );
  }

  Widget _buildLeft(String route) {
    if (route == "/home") {
      return  Padding(padding: EdgeInsets.all(10.0),
      child: Row(children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: UserCache().avatar != null
                      ? NetworkImage(UserCache().avatar!)
                      : null,
                  child: UserCache().avatar == null
                      ? const Icon(Icons.person, color: Colors.white)
                      : null,
                ),
                SizedBox(width: 12),
                Column(crossAxisAlignment: CrossAxisAlignment.start,children:[
                  Text("Welcome Back,", style: TextStyle(fontSize: 20, color: Colors.white)),
                  Row(children: [Text(UserCache().name ?? "", style: TextStyle(fontSize: 20, color: Colors.white)),SizedBox(width: 5,),GestureDetector(onTap: () {context.push('/profile');},child: Icon(Icons.expand_more, color: Colors.white),)],)
                ])
                ],)
              );
    }
    if (route == "/gallery") {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(Icons.arrow_back, color: Colors.white),
      );
    }
    return const SizedBox(width: 0);
  }

  Widget _buildCenter(String route) {
    if (route == "/home") {
      return  Padding(padding: EdgeInsets.all(10.0),
    
              );
    }
    if (route == "/gallery") {
      return const Text("Gallery",
          style: TextStyle(fontSize: 20, color: Colors.white));
    }
    return const SizedBox(width:0);
  }

  Widget _buildRight(String route) {
    if (route == "/home") {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(Icons.person, color: Colors.white),
      );
    }
    return const SizedBox(width: 0);
  }
}
