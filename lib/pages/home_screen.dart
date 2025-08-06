// home_screen.dart
import 'package:flutter/material.dart';
import 'package:xii_rpl_3/pages/auth/login_screen.dart';
import 'package:xii_rpl_3/services/auth_service.dart';
 
 class HomeScreen extends StatelessWidget {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _authService.logout();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
            },
          )
        ],
      ),
      body: Center(child: Text("Selamat datang di halaman Home!")),
    );
  }
 }