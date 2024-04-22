import 'package:android/components/button_widget.dart';
import 'package:android/components/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatelessWidget {
  final void Function()? onTap;

  LoginPage({super.key, this.onTap});

  //text controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //login method
  void login() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              SizedBox(height: 25.h),

              //app name
              Text(
                "A N D R O I D",
                style: TextStyle(fontSize: 20.sp),
              ),
              SizedBox(height: 50.h),
              //email
              TextFieldWidget(
                  hinText: "Email",
                  obscureText: false,
                  controller: emailController),

              SizedBox(height: 10.h),
              //password
              TextFieldWidget(
                  hinText: "Password",
                  obscureText: true,
                  controller: passwordController),
              SizedBox(height: 10.h),
              //forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  )
                ],
              ),
              SizedBox(height: 25.h),
              //sigin in
              ButtonWidget(
                text: "Login",
                onTap: login,
              ),
              SizedBox(height: 25.h),
              //dont have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Dont have an account?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: const Text(
                      " Register here",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
