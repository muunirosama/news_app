
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:news_app/cores/extensions/Padding.dart';

import '../../../cores/Services/FirebaseAuth.dart';
import '../../../cores/extensions/validtions.dart';
import '../../../cores/routes/pages_routes_name.dart';
import '../../../cores/themes/color_pallete.dart';
import '../../../cores/widgets/custom_text_field.dart';
import '../../../main.dart';


class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: ColorPalette.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorPalette.primaryColor,
        title: Text(
            "Register",
            style: TextStyle(
              color: ColorPalette.secondaryColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: ColorPalette.secondaryColor,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Image.asset(
                     "assets/images/gamer (1).png",
                     height: 150,
                     width: 150,
                   ),
                 ],
               ).setHorizontalAndVerticalPadding(context, 0.025,0.015),
          
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextField(
                    controller: nameController,
                    hint: "Name",
                    hintColor: ColorPalette.secondaryColor,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "plz enter your name";
                      }
                      return null;
                    },
                    prefixIcon: const ImageIcon(
                      AssetImage(
                        "assets/images/🦆 icon _Identification_.png",
                      ),
                      color: ColorPalette.secondaryColor,
                    ),
                  ).setOnlyPadding(context, 0.03, 0.0, 0.0, 0.0),
                ),
          
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextField(
                    controller: emailController,
                    hint: "Email",
                    hintColor: ColorPalette.secondaryColor,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "plz enter your email address";
                      }
                      if (!Validations.validateEmail(value)) {
                        return "plz enter your a valid email address";
                      }
                      return null;
                    },
                    prefixIcon: Icon(
                      Icons.mail
                  ),
                  ).setHorizontalAndVerticalPadding(context, 0.005,0.015),
                ),
          
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextField(
                    controller: passwordController,
                    isPassword: true,
                    maxLines: 1,
                    hint: "Password",
                    hintColor: ColorPalette.secondaryColor,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "plz enter your password";
                      }
                      if (!Validations.validatePassword(value)) {
                        return "plz enter your a valid password";
                      }
                      return null;
                    },
                    prefixIcon:Icon(
                        Icons.lock
                    ),
                ),
                ),
          
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  child: CustomTextField(
                    controller: passwordController,
                    isPassword: true,
                    maxLines: 1,
                    hint: "Confirm Password",
                    hintColor: ColorPalette.secondaryColor,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "plz enter your password";
                      }
                      if (value != passwordController.text) {
                        return "re-password not match.";
                      }
                      return null;
                    },
                    prefixIcon: Icon(
                        Icons.lock
                    ),
                ),
                ),
          
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16,),
                  child: CustomTextField(
                    hint: "Phone Number",
                    hintColor: ColorPalette.secondaryColor,
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                  ),
                ),
          
          
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        FirebaseAuthFunction.createAccount(
                          emailAddress: emailController.text,
                          password: passwordController.text,
                        ).then(
                              (value) {
                            EasyLoading.dismiss();
                            if (value==true) {
                              navigatorKey.currentState!.pushNamedAndRemoveUntil(
                                PagesRouteName.signIn,
                                    (route) => false,
                              );
                            }
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: ColorPalette.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        side: BorderSide(
                          color: ColorPalette.secondaryColor
                        )
                      ),
                    ),
                    child: Text(
                      "Create Account",
                      style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ColorPalette.secondaryColor
                      ),
                    ).setVerticalPadding(context, 0.015),
                  ).setVerticalPadding(context, 0.025),
                ),
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have account ?",
                      style: TextStyle(
                        color: ColorPalette.secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          navigatorKey.currentState!.pop();
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: ColorPalette.secondaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            decorationColor: ColorPalette.primaryColor,
                          ),
                        )
                    )
                  ],
                ),
               ]
             ),
          ),
        ),
      )
      );
  }
}
