import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twnty2/Helper/Router/router.dart';
import 'package:twnty2/Screens/AuthScreen/UI/auth_screen.dart';
import '../../../Helper/SharedPreferance/shared_preferance.dart';
import '../MainScreen/UI/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplashScreen> {


  navigationFunction(context) async {
    await Future.delayed(const Duration(milliseconds: 2000));
    if (SpHelper.spHelper.getTokenId() != '') {
      RouterHelper.routerHelper
          .routingReplacement( const MainScreen());
    } else {
      RouterHelper.routerHelper
          .routingReplacement( AuthScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    navigationFunction(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: Text(
      'Test App Flutter \n By Mohammed AbuAmra',
      style: TextStyle(fontSize: 20, color: Colors.black),
      textAlign: TextAlign.center,
    )));
  }
}
