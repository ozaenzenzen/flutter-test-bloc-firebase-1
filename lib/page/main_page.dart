import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_bloc_1/bloc/bloc/auth_bloc.dart';
import 'package:test_bloc_1/page/signin_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ScreenUtil screenUtil = ScreenUtil();

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(
    //     BoxConstraints(
    //         maxWidth: MediaQuery.of(context).size.width,
    //         maxHeight: MediaQuery.of(context).size.height),
    //     designSize: const Size(360, 690),
    //     context: context,
    //     minTextAdapt: true,
    //     orientation: Orientation.portrait);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan.shade600,
          centerTitle: true,
          title: Text(
            "Test Bloc 1",
            style: GoogleFonts.poppins(
              // fontSize: 18.sp,
              // fontSize: screenUtil.setSp(18),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            // debugPrint("State now: ${state!}");
            if (state is AuthLoading) {
              const CircularProgressIndicator();
            }
            if (state is AuthUnauthenticated) {
              Get.off(() => const SignInPage());
              // Navigator.of(context).pushAndRemoveUntil(
              //   MaterialPageRoute(builder: (context) => const SignInPage()),
              //   (route) => false,
              // );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                user.photoURL ?? "https://freesvg.org/img/1534129544.png",
                // height: 100.h,
                // width: 100.h,
                height: screenUtil.setHeight(100),
                width: screenUtil.setWidth(100),
              ),
              SizedBox(
                height: screenUtil.setHeight(10),
              ),
              Container(
                alignment: Alignment.center,
                child: Text("${user.displayName}"),
              ),
              SizedBox(
                height: screenUtil.setHeight(10),
              ),
              Container(
                alignment: Alignment.center,
                child: Text("${user.email}"),
              ),
              SizedBox(
                height: screenUtil.setHeight(20),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.cyan.shade600,
                ),
                onPressed: () {
                  context.read<AuthBloc>().add(SignOutRequested());
                },
                child: Text(
                  "Sign Out",
                  style: GoogleFonts.poppins(
                    // fontSize: 12.sp,
                    fontSize: screenUtil.setSp(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
