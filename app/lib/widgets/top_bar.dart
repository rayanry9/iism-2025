import 'package:flutter/material.dart';
import 'package:iism_2025/widgets/dynamic_bar.dart';
import 'package:dio/dio.dart';
import 'package:iism_2025/screens/logindetails.dart'; 
import 'package:iism_2025/services/user_cache.dart';
import 'package:iism_2025/services/user_loader.dart';
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
    load();
  }
  Future<void> load() async {
    await loadUserData();   
    loading = false;
    setState(() {});
  }

 

  @override
Widget build(BuildContext context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(kToolbarHeight),
    child: DynamicNavbar(
      background: const Color(0xFF191C2A),
      left: _buildLeft(widget.route),
      center: _buildCenter(widget.route),
      right: _buildRight(widget.route),
    ),
  );
}

  Widget _buildLeft(String route) {
    if (route == "/home") {
      return  Padding(padding: EdgeInsets.all(10.0),
      child: Row(children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: UserCache().profilePic != null
                      ? NetworkImage(UserCache().profilePic!)
                      : null,
                  child: UserCache().profilePic == null
                      ? const Icon(Icons.person, color: Colors.white)
                      : null,
                ),
                SizedBox(width: 12),
                Column(crossAxisAlignment: CrossAxisAlignment.start,children:[
                  Text("Welcome Back,", style: TextStyle(fontSize: 20, color: Colors.white)),
                  Row(children: [Text(UserCache().firstName ?? "", style: TextStyle(fontSize: 20, color: Colors.white)),SizedBox(width: 5,),GestureDetector(onTap: () {context.push('/profile');},child: Icon(Icons.expand_more, color: Colors.white),)],)
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
    if (route == "/profile") {
      return const Padding(
        padding: EdgeInsets.all(50.0),
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
      return  Text("Gallery",
          style: TextStyle(fontSize: 20, color: Colors.white));
    }
    if(route.startsWith("/profile")){
      return   Padding(padding: EdgeInsets.all(10.0),
                child:Text("PROFILE",
          style: TextStyle(fontSize: 20, color: Colors.white))
              );
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
