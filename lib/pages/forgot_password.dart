import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hydrow/backend/api_requests/register_device.dart';
import 'package:hydrow/constants/k_generalized.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    print("Reset password initaited");
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
        context: context,
        builder: (alertDialogContext) {
          return customAlertDialog(
            'S U C C E S S',
            'Password reset link sent! Check your email',
            [
              actionBtnWidget(
                "C L O S E",
                onPressed: () {
                  Navigator.pop(alertDialogContext);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (alertDialogContext) {
          return customAlertDialog(
            'E R R O R',
            e.message!,
            [
              actionBtnWidget(
                "C L O S E",
                onPressed: () {
                  Navigator.pop(alertDialogContext);
                },
              ),
            ],
          );
        },
      );
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genAppBar("Reset Password"),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0), //(8.0),
            child: customTextField(
              _emailController,
              'Email',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Container(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  passwordReset();
                },
                child: Text(
                  "Reset password",
                  style: TextStyle(
                      fontFamily: 'Spartan',
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Color(0xFFC6DDDB),
                  foregroundColor: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget customTextField(TextEditingController? controller, String hintText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 31, 16, 16),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          fontFamily: 'Spartan',
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.white,
            width: 0.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
        labelStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }
}
