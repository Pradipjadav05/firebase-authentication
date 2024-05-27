import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication_demo/login_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome...😊"),
            ElevatedButton(
              onPressed: () async{
                try {
                  await FirebaseAuth.instance.signOut();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Signed out successfully.'),
                  ));
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Failed to sign out.'),
                  ));
                  debugPrint('Failed to sign out: $e');
                }
              },
              child: const Text("Logout"),
            )
          ],
        ),
      ),
    );
  }
}
