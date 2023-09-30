import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Cubit/auth_cubit.dart';
import '../Cubit/auth_states.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      create: (BuildContext context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (cnx, state) => {},
        builder: (cnx, state) => Scaffold(
          body: Center(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1000)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: AuthCubit.get(cnx).isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.green,
                        strokeWidth: 2,
                      )
                    : InkWell(
                        onTap: () {
                          AuthCubit.get(cnx).signInWithGoogle();
                        },
                        child: Image.asset(
                          'assets/images/google.png',
                          width: 70.r,
                          height: 70.r,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
