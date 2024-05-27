import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../home_screen.dart';

class AuthService {


  /*
  * Register user
  * */
  Future<String> registration({required String email, required String password}) async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return 'Success';
    }
    on FirebaseAuthException catch(e){
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message.toString();
      }
    }
    catch(e){
      return e.toString();
    }
  }

  /*
  * Login user
  * */
  Future<String> login({required String email, required String password}) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return 'Success';
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message.toString();
      }
    } catch (e) {
      return e.toString();
    }
  }


  /*
  * Google SignIn
  * */
  static Future<String> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        }
        else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }

    return 'Success';
  }


  /*
  * Google SignOut
  * */
  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to sign out.'),
      ));
    }
  }


  /*
  * Login with Mobile Number
  * */
  static Future<void> loginWithMobile({required BuildContext context, required String mobile}) async{
    final codeController = TextEditingController();
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: const Duration(seconds: 60),
        /*
        * verificationCompleted Triggered when an SMS is auto-retrieved or the phone number has been instantly verified.
        * */
        verificationCompleted: (AuthCredential credential) async{
          Navigator.of(context).pop();

          final result = await FirebaseAuth.instance.signInWithCredential(credential);

          User? user = result.user;

          if(user != null){
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => const HomeScreen()
            ));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("success"),
              ),
            );
          }else{
            debugPrint("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        /*
        * verificationFailed Triggered when an error occurred during phone number verification.
        * */
        verificationFailed: (FirebaseAuthException exception){
          debugPrint(exception.toString());
        },

        /*
        * ued for send verification code on user enter mobile number
        * */
        codeSent: (String verificationId, int? forceResendingToken){
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Give the code?"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text("Confirm"),
                      onPressed: () async{
                        final code = codeController.text.trim();
                        AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);

                        final result = await FirebaseAuth.instance.signInWithCredential(credential);

                        User? user = result.user;

                        if(user != null){
                          //close dialog
                          Navigator.of(context).pop();
                          // move to home page
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => const HomeScreen()
                          ));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("success"),
                            ),
                          );
                        }else{
                          debugPrint("Error");
                        }
                      },
                    )
                  ],
                );
              }
          );
        },


        codeAutoRetrievalTimeout: (String res){},
    );
  }

}