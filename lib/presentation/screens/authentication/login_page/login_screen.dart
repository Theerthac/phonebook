// import 'package:flutter/material.dart';
// import 'package:phonebook/core/constants/colors.dart';
// import 'package:phonebook/presentation/widgets/custom_button.dart';
// import 'package:phonebook/presentation/widgets/custom_text.dart';
// import 'package:phonebook/presentation/widgets/custom_textfield.dart';
// import 'package:phonebook/presentation/widgets/spacing_extensions.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: colorWhite,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CustomTextField(
//               borderColor: greyBorder,
//               fillColor: colorWhite,
//               hintText: 'Email',
//               boxname: 'Email',
//               leadingIcon: Icons.email_outlined,
//             ),
//             10.hBox,
//             CustomTextField(
//               borderColor: greyBorder,
//               fillColor: colorWhite,
//               hintText: 'Password',
//               boxname: 'Password',
//               leadingIcon: Icons.lock_outline_sharp,
//               obscureText: true,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 const AppText(
//                   "Don’t have account Sign in ?",
//                   size: 13,
//                   weight: FontWeight.w600,
//                 ),
//                 GestureDetector(
//                   onTap: () {},
//                   child: const AppText(
//                     color: secondbuttonclr,
//                     " Click Here",
//                     size: 13,
//                     weight: FontWeight.w700,
//                   ),
//                 ),
//               ],
//             ),

//             30.hBox,
//             CustomButton(
//               boxColor: secondbuttonclr,
//               fontSize: 16,
//               textColor: colorWhite,
//               weight: FontWeight.w500,
//               onTap: () {},
//               text: 'Login',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:phonebook/core/constants/colors.dart';
import 'package:phonebook/presentation/screens/authentication/signup/signup.dart';
import 'package:phonebook/presentation/widgets/custom_button.dart';
import 'package:phonebook/presentation/widgets/custom_text.dart';
import 'package:phonebook/presentation/widgets/custom_textfield.dart';
import 'package:phonebook/presentation/widgets/spacing_extensions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            40.hBox,
            Center(
              child: Icon(
                Icons.contact_phone,
                color: secondbuttonclr,
                size: 80,
              ),
            ),
            20.hBox,
            const AppText(
              "Welcome Back!",
              size: 28,
              weight: FontWeight.bold,
              color: Colors.black87,
            ),
            6.hBox,
            const AppText(
              "Login to continue to PhoneBook",
              size: 14,
              color: Colors.grey,
            ),
            30.hBox,

            CustomTextField(
              borderColor: greyBorder,
              fillColor: Colors.grey[50]!,
              hintText: 'Email',
              boxname: 'Email',
              leadingIcon: Icons.email_outlined,
            ),
            15.hBox,

            CustomTextField(
              borderColor: greyBorder,
              fillColor: Colors.grey[50]!,
              hintText: 'Password',
              boxname: 'Password',
              leadingIcon: Icons.lock_outline_sharp,
              obscureText: true,
              showPasswordToggle: true,
            ),
            10.hBox,

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const AppText(
                  "Don’t have an account?",
                  size: 13,
                  color: Colors.black54,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  child: const AppText(
                    " Sign up",
                    size: 13,
                    weight: FontWeight.bold,
                    color: secondbuttonclr,
                  ),
                ),
              ],
            ),

            40.hBox,

            CustomButton(
              boxColor: secondbuttonclr,
              fontSize: 16,
              textColor: colorWhite,
              weight: FontWeight.w600,
              onTap: () {},
              text: 'Login',
            ),
          ],
        ),
      ),
    );
  }
}
