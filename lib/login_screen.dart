import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication_demo/home_screen.dart';
import 'package:flutter/material.dart';

import 'create_account.dart';
import 'mobile_login.dart';
import 'services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _forgotEmailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                // Email TextField
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(hintText: 'Email'),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                // Password TextField
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                // Login Button
                ElevatedButton(
                  onPressed: () async {
                    final message = await AuthService().login(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    if (message.contains('Success')) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                      ),
                    );
                  },
                  child: const Text('Login'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MobileLogin(),
                      ),
                    );
                  },
                  child: const Text('SignIn with Mobile Number?'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Create Account Button
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CreateAccount(),
                          ),
                        );
                      },
                      child: const Text('Create Account'),
                    ),
                    const Text(" | "),
                    // Forgot Password Button
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              insetPadding: EdgeInsets.zero,
                              title: const Text('Forgot Password'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text("Enter Email get rest password link."),
                                  TextField(
                                    controller: _forgotEmailController,
                                    decoration: const InputDecoration(
                                      hintText: 'Email Address',
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    try {
                                      await _auth
                                          .sendPasswordResetEmail(
                                              email: _forgotEmailController.text)
                                          .then((value) {
                                        _forgotEmailController.clear();
                                        Navigator.pop(context);
                                      });
                                    } on FirebaseAuthException catch (err) {
                                      throw Exception(err.message.toString());
                                    } catch (err) {
                                      throw Exception(err.toString());
                                    }
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Forgot Password?'),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Google SignIn Button
                ElevatedButton(
                  onPressed: () async{
                    final message = await AuthService.signInWithGoogle(context: context);
                    if (message.contains('Success')) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                      ),
                    );
                  },
                  child: const Text("Google"),
                ),
                //Google SignIn Button
                ElevatedButton(
                  onPressed: () async{
                    final message = await AuthService.signInWithGoogle(context: context);
                    if (message.contains('Success')) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                      ),
                    );
                  },
                  child: const Text("FaceBook"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void checkCurrentUser() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      User? user = _auth.currentUser;
      if (user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    });
  }
}
