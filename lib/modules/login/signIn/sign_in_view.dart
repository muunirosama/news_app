import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:news_app/cores/extensions/Padding.dart';
import '../../../cores/Services/FirebaseAuth.dart';
import '../../../cores/extensions/validtions.dart';
import '../../../cores/routes/pages_routes_name.dart';
import '../../../cores/themes/color_pallete.dart';
import '../../../cores/widgets/custom_text_field.dart';
import '../../../main.dart';


class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery= MediaQuery.of(context);
    return Scaffold(
      backgroundColor: ColorPalette.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset("assets/images/news_logo.png",
                height: mediaQuery.size.height * 0.30,
                ),
          
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextField(
                    controller: _emailController,
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
                  ).setOnlyPadding(context, 0.03, 0.015, 0.0, 0.0),
                ),
          
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextField(
                    controller: _passwordController,
                    isPassword: true,
                    maxLines: 1,
                    hint: "Password",
                    hintColor: ColorPalette.secondaryColor,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "plz enter your email address";
                      }
                      return null;
                    },
                    prefixIcon:
                    Icon(
                        Icons.lock
                    ),
                  ),
                ),
          
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(onPressed: (){
                    Navigator.pushNamed(context,
                        PagesRouteName.forgetPassword
                    );
                  },
                      child: Text("Forget Password ?",
                      style: TextStyle(
                        color: ColorPalette.secondaryColor,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: ColorPalette.secondaryColor,
                      ),
                      )
                  ),
                ),
          
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        FirebaseAuthFunction.login(
                            emailAddress: _emailController.text,
                            password: _passwordController.text)
                            .then(
                              (value) {
                            EasyLoading.dismiss();
                            if (value) {
                              navigatorKey.currentState!.pushNamedAndRemoveUntil(
                                PagesRouteName.home,
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
                            side: const BorderSide(
                              color:  ColorPalette.secondaryColor,
                            )
                        )
                    ),
                    child: Text(
                      "Login",
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
                    const Text("Don't have account ?",
                      style: TextStyle(
                        color: ColorPalette.secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context,
                              PagesRouteName.signUp
                          );
                        },
                      child: Text("Create account",
                        style: TextStyle(
                          color: ColorPalette.secondaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          decorationColor: ColorPalette.secondaryColor,
                        ),
                      )
                      )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 2,
                          color: ColorPalette.secondaryColor,
                          indent: 20,
                          endIndent: 20,
                        ),
                      ),
                  Text("OR",
                    style: TextStyle(
                      color: ColorPalette.secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                      Expanded(
                        child: Divider(
                          thickness: 2,
                          color: ColorPalette.secondaryColor,
                          indent: 20,
                          endIndent: 20,
                        ),
                      ),
                  ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                  child: ElevatedButton(onPressed: (){},
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: ColorPalette.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            side: const BorderSide(
                              color:  ColorPalette.secondaryColor,
                            )
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/🦆 icon _google_.png",
                            color:ColorPalette.secondaryColor ,
                            height: 25,
                          ),
                           const SizedBox(width: 10,),
                           const Text("login with Google",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.secondaryColor,
                                fontSize: 18
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

