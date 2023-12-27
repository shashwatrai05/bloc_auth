import 'package:bloc_auth/cubit/auth_cubit/auth_cubit.dart';
import 'package:bloc_auth/cubit/auth_cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({super.key});

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Colors.blue, title: const Text('Sign In')),
      body: SafeArea(
          child: Padding(
        padding:
            const EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 15),
        child: Column(
          children: <Widget>[
            TextField(
              controller: otpController,
              maxLength: 6,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Enter OTP"),
            ),
            const SizedBox(
              height: 15,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLoggedInState){
                  Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const HomeScreen()));
                }
                else if(state is AuthErrorState){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error),
                    backgroundColor: Colors.red,)
                  );
                }
              },
              builder: (context, state) {
                if(state is AuthLoadingState){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SizedBox(
                  child: CupertinoButton(
                    child: const Text("Verify"),
                    onPressed: () {
                     BlocProvider.of<AuthCubit>(context).verifyOTP(otpController.text);
                    },
                    color: Colors.blue,
                  ),
                );
              },
            )
          ],
        ),
      )),
    );
  }
}
