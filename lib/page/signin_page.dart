import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_bloc_1/bloc/bloc/auth_bloc.dart';
import 'package:test_bloc_1/page/main_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.cyan.shade600,
      //   title: Text("Test Bloc 1"),
      // ),
      body: Container(
        margin: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 10.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bloc Sign In",
              style: GoogleFonts.poppins(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      return value != null && !EmailValidator.validate(value)
                          ? 'Enter a valid email'
                          : null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      return value != null && value.length < 6
                          ? "Enter min. 6 characters"
                          : null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       "Email",
            //       style: GoogleFonts.poppins(
            //         fontSize: 14.sp,
            //       ),
            //     ),
            //     SizedBox(
            //       height: 5.h,
            //     ),
            //     SizedBox(
            //       height: 40.h,
            //       child: TextField(
            //         textAlignVertical: TextAlignVertical.center,
            //         controller: emailController,
            //         decoration: InputDecoration(
            //           hintText: 'Email',
            //           hintStyle: GoogleFonts.poppins(
            //             fontSize: 12.sp,
            //           ),
            //           border: const OutlineInputBorder(
            //             borderSide: BorderSide(),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: 15.h,
            // ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       "Password",
            //       style: GoogleFonts.poppins(
            //         fontSize: 14.sp,
            //       ),
            //     ),
            //     SizedBox(
            //       height: 5.h,
            //     ),
            //     SizedBox(
            //       height: 40.h,
            //       child: TextField(
            //         textAlignVertical: TextAlignVertical.center,
            //         controller: passwordController,
            //         decoration: InputDecoration(
            //           hintText: 'Password',
            //           hintStyle: GoogleFonts.poppins(
            //             fontSize: 12.sp,
            //           ),
            //           border: const OutlineInputBorder(
            //             borderSide: BorderSide(),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 20.h,
            ),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthAuthenticated) {
                  Get.off(() => const MainPage());
                }
                if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is AuthUnauthenticated) {
                  return Column(
                    children: [
                      SizedBox(
                        width: 230.w,
                        height: 30.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.cyan.shade600,
                          ),
                          onPressed: () {
                            // Get.to(() => const MainPage());
                            _authenticateWithEmailAndPassword(context);
                          },
                          child: Text(
                            "Sign In",
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      InkWell(
                        onTap: () {
                          // Get.to(() => const MainPage());
                          _authenticateWithGoogle(context);
                        },
                        child: Container(
                          color: Colors.white,
                          child: Image.network(
                            "https://freesvg.org/img/1534129544.png",
                            height: 30.h,
                            width: 30.h,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Alredy have an account? ',
                            style: GoogleFonts.poppins(
                              fontSize: 11.sp,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              //
                              debugPrint("debugPrint");
                            },
                            child: Text(
                              'Sign Up',
                              style: GoogleFonts.poppins(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      // SizedBox(
                      //   width: 230.w,
                      //   height: 40.h,
                      //   child: ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //       primary: Colors.cyan.shade600,
                      //     ),
                      //     onPressed: () {
                      //       // Get.to(() => const MainPage());
                      //       _authenticateWithGoogle(context);
                      //     },
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Image.network(
                      //           "https://freesvg.org/img/1534129544.png",
                      //           height: 30.h,
                      //           width: 30.h,
                      //         ),
                      //         SizedBox(
                      //           width: 20.w,
                      //         ),
                      //         Text(
                      //           "Sign In With Google",
                      //           style: GoogleFonts.poppins(
                      //             fontSize: 12.sp,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(
          emailController.text,
          passwordController.text,
        ),
      );
    }
  }

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested(),
    );
  }
}
