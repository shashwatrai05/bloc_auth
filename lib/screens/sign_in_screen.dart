import 'package:bloc_auth/cubit/auth_cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit/auth_cubit.dart';
import '/screens/verfiy_otp_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class SignInScreen extends StatelessWidget {
  TextEditingController phoneController = TextEditingController();

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
              controller: phoneController,
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Phone Number"),
            ),
            const SizedBox(
              height: 15,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthCodeSentState){
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const VerifyOTPScreen()));
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
                    child: const Text("Get OTP"),
                    onPressed: () {
                      String phoneNumber= "+91" + phoneController.text;
                      BlocProvider.of<AuthCubit>(context).sendOTP(phoneNumber);
                      
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
