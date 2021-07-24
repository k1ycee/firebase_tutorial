import 'package:flutter/material.dart';
import 'package:tuts/UI/views/home_screen.dart';
import 'package:tuts/UI/widgets/button.dart';
import 'package:tuts/logic/auth.dart';
import 'package:tuts/utils/colors.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Auth auth = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 75,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Facebook',
                style: TextStyle(
                    color: lightBlue, fontSize: 20, fontWeight: FontWeight.w800),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Connect with friends and stay safe',
                style: TextStyle(
                    color: black, fontSize: 20, fontWeight: FontWeight.w800),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  hintText: "Email Address",
                  hintStyle: TextStyle(color: lightGrey),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  hintText: "Password",
                  hintStyle: TextStyle(color: lightGrey),
                ),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: RichText(
                text: TextSpan(
                  text: 'By signing up, you have accepted the ',
                  style: TextStyle(
                      fontSize: 12,
                      color: lightGrey,
                      fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Terms and\nConditions',
                        style: TextStyle(
                            color: lightBlue, fontWeight: FontWeight.w600)),
                    TextSpan(
                        text: ' of this service',
                        style: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  button(
                      onPressed: () async {
                        await auth.signIn(
                            email: emailController.text,
                            password: passwordController.text);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                      text: "Sign In",
                      textColor: Colors.white,
                      buttonColor: lightBlue,
                      height: 70,
                      width: 150),
                  button(
                      onPressed: () async {
                        await auth.signUp(
                            email: emailController.text,
                            password: passwordController.text);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                      text: "Register",
                      textColor: Colors.white,
                      buttonColor: darkBlue,
                      height: 70,
                      width: 200)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

