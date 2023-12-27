import 'package:bloc_auth/cubit/auth_cubit/auth_cubit.dart';
import 'package:bloc_auth/screens/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit/auth_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Sign In'),
      ),
      body: Container(
        child: Center(
            child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLoggedOutState){
                  Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => SignInScreen()));
                }
          },
          builder: (context, state) {
            return CupertinoButton(
              child: Text('Logout'),
              onPressed: () {
                BlocProvider.of<AuthCubit>(context).logOut();
              },
            );
          },
        )),
      ),
    );
  }
}
