import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phonebook/core/constants/colors.dart';
import 'package:phonebook/presentation/screens/authentication/cubit/auth_cubit.dart';
import 'package:phonebook/presentation/screens/authentication/login_page/login_screen.dart';
import 'package:phonebook/presentation/widgets/custom_button.dart';
import 'package:phonebook/presentation/widgets/custom_text.dart';
import 'package:phonebook/presentation/widgets/custom_textfield.dart';
import 'package:phonebook/presentation/widgets/spacing_extensions.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocProvider(
          create: (context) => AuthCubit(),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              final cubit = context.read<AuthCubit>();
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const AppText(
                        "Create Account",
                        size: 23,
                        weight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      6.hBox,
                      const AppText(
                        "Sign up to get started with PhoneBook",
                        size: 14,
                        color: Colors.grey,
                      ),
                      30.hBox,

                      CustomTextField(
                        controller: cubit.emailController,
                        borderColor: greyBorder,
                        fillColor: Colors.grey[50]!,
                        hintText: 'Email',
                        boxname: 'Email',
                        leadingIcon: Icons.email_outlined,
                      ),
                      10.hBox,

                      CustomTextField(
                        controller: cubit.passwordController,
                        borderColor: greyBorder,
                        fillColor: Colors.grey[50]!,
                        hintText: 'Password',
                        boxname: 'Password',
                        leadingIcon: Icons.lock_outline_sharp,
                        obscureText: true,
                        showPasswordToggle: true,
                      ),
                      10.hBox,
                      CustomTextField(
                        controller: cubit.confirmPasswordController,
                        borderColor: greyBorder,
                        fillColor: Colors.grey[50]!,
                        hintText: 'Confirm Password',
                        boxname: 'Confirm Password',
                        leadingIcon: Icons.lock_outline_sharp,
                        obscureText: true,
                        showPasswordToggle: true,
                      ),
                      10.hBox,

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const AppText(
                            "Already have an account?",
                            size: 13,
                            color: Colors.black54,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            child: const AppText(
                              " Login",
                              size: 13,
                              weight: FontWeight.bold,
                              color: primaryclr,
                            ),
                          ),
                        ],
                      ),

                      40.hBox,

                      CustomButton(
                        boxColor: primaryclr,
                        fontSize: 16,
                        textColor: colorWhite,
                        weight: FontWeight.w600,
                        onTap: () async {
                          bool success = await cubit.signUpFunction();
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Signup Successfully'),
                                backgroundColor: Color(0xFF47BA82),
                                behavior: SnackBarBehavior.floating,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Sign up failed. Please try again.',
                                ),
                              ),
                            );
                          }
                        },
                        text: 'Sign Up',
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
