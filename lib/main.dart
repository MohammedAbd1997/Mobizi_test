import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twnty2/Screens/AuthScreen/UI/auth_screen.dart';

import 'Helper/Notifications/notification_helper.dart';
import 'Helper/Router/router.dart';
import 'Helper/SharedPreferance/shared_preferance.dart';
import 'Screens/SplashScreen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SpHelper.spHelper.initSharedPrefrences();
  await NotificationHelper.notificationHelper.initNotification();
  runApp(MyApps());
}

class MyApps extends StatefulWidget {
  const MyApps({Key? key}) : super(key: key);

  @override
  State<MyApps> createState() => _MyAppsState();
}

class _MyAppsState extends State<MyApps> {
  @override
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 811),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      splitScreenMode: true,
      builder: (context, widget) => MaterialApp(
        navigatorKey: RouterHelper.routerHelper.routerKey,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
