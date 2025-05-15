import 'package:flutter/material.dart';
import 'package:news_app/cores/extensions/Padding.dart';

import '../../../cores/themes/color_pallete.dart';
import '../../../cores/widgets/custom_text_field.dart';


class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return  Scaffold(
      backgroundColor: ColorPalette.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorPalette.primaryColor,
        title: Text("Forget Password",
            style: TextStyle(
              color: ColorPalette.secondaryColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            )
        ),
        iconTheme: IconThemeData(
          color: ColorPalette.secondaryColor,
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Image.asset('assets/images/Forgot password-bro 1.png',
            ),
          ),
          const SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const CustomTextField(
              hint: "Email",
              hintColor: ColorPalette.secondaryColor,
              prefixIcon: Icon(
              Icons.mail
              ),
            ).setOnlyPadding(context, 0.015, 0.0, 0.0, 0.0),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: ColorPalette.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    side: BorderSide(
                      color: ColorPalette.secondaryColor
                    )
                  )
              ),
              child: Text(
                "Verify Email",
                style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.secondaryColor
                ),
              ).setVerticalPadding(context, 0.015),
            ).setVerticalPadding(context, 0.025),
          ),

        ],
      )
    );
  }
}
