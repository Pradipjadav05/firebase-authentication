import 'package:firebase_authentication_demo/services/auth_service.dart';
import 'package:flutter/material.dart';

class MobileLogin extends StatefulWidget {
  const MobileLogin({super.key});

  @override
  State<MobileLogin> createState() => _MobileLoginState();
}

class _MobileLoginState extends State<MobileLogin> {
  final TextEditingController _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mobile Login"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Mobile TextField
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _mobileController,
                decoration: const InputDecoration(hintText: 'Mobile'),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            // Login Button
            ElevatedButton(
              onPressed: (){
                AuthService.loginWithMobile(context: context, mobile: _mobileController.text);
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
