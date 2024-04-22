import 'package:android/components/button_widget.dart';
import 'package:android/components/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterPage extends StatelessWidget {
  final void Function()? onTap;

  RegisterPage({super.key, this.onTap});
  //text controller
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

  //login method
  void register() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
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
                //username
                TextFieldWidget(
                    hinText: "Username",
                    obscureText: false,
                    controller: userNameController),

                SizedBox(height: 10.h),
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
                //confirm password
                TextFieldWidget(
                    hinText: "Confirm Password",
                    obscureText: true,
                    controller: confirmPwController),
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
                  text: "Register",
                  onTap: register,
                ),
                SizedBox(height: 25.h),
                //dont have an account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: const Text(
                        " Login here",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
