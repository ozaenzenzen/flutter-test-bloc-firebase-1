import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_bloc_1/page/main_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(340, 640),
      builder: () {
        return GetMaterialApp(
          title: 'Test Bloc 1',
          home: MainPage(),
          defaultTransition: Transition.cupertino,
        );
      }
    );
  }
}