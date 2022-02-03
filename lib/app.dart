import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_bloc_1/bloc/bloc/auth_bloc.dart';
import 'package:test_bloc_1/data/repositories/auth_repository.dart';
import 'package:test_bloc_1/page/main_page.dart';
import 'package:test_bloc_1/page/signin_page.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart'
    as transition;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // bool isLogin = false;
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
        ],
        child: ScreenUtilInit(
            // key: _scaffoldKey,
            designSize: const Size(340, 640),
            builder: () {
              return GetMaterialApp(
                title: 'Test Bloc 1',
                home: StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return const MainPage();
                    }
                    return const SignInPage();
                  },
                ),
                builder: (context, widget) {
                  ScreenUtil.setContext(context);
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: widget ?? const SizedBox(),
                  );
                },
                defaultTransition: transition.Transition.cupertino,
              );
            }),
      ),
    );
  }
}
