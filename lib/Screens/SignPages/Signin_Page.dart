import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants.dart';
import '../../logic/Auth_Cubit.dart';
import 'DecorationWidgets.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);
  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  FToast fToast = FToast();
  var _fromkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();
  bool hidden = false;
  String email = '', password = '';
  bool isPressed = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: appBackground,
      body: Form(
        key: _fromkey,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: height * 0.09,
            ),
            const Center(
              child: Text(
                "Hello Again!",
                style: TextStyle(color: textColor, fontSize: 28),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            const Center(
              child: Text(
                "Welcome Back You've Been Missed",
                style: TextStyle(color: textGreyColor, fontSize: 16),
              ),
            ),
            SizedBox(
              height: height * 0.08,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.025),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email Address',
                    style: TextStyle(color: textColor, fontSize: 16),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  CustomEmailTextField(
                    emailController: emailController,
                    height: height,
                    width: width,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    'Password',
                    style: TextStyle(color: textColor, fontSize: 16),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  CustomPasswordTextField(
                      controller: passwordController,
                      height: height,
                      width: width,
                      isObscure: hidden,
                      onPressed: () {
                        setState(() {
                          hidden = !hidden;
                        });
                      }),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/Recovery');
                      },
                      child: const Text(
                        'Password Recovery',
                        style: TextStyle(color: textGreyColor, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Container(
                    width: width,
                    height: height * 0.08,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: buttonColor),
                    child: TextButton(
                      onPressed: () async {
                        if (_fromkey.currentState!.validate()) {
                          await BlocProvider.of<AuthCubit>(context).SignIn(
                              emailController!.text, passwordController!.text);
                        }
                      },
                      child: buildLogin(),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.10,
                  ),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/SignUp');
                        },
                        child: const Text.rich(TextSpan(
                          text: 'Don\'t have an account  ',
                          style: TextStyle(color: textGreyColor, fontSize: 14),
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'Sign Up for free',
                              style: TextStyle(color: linkColor, fontSize: 14),
                            )
                          ],
                        ))),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLogin() {
    return BlocConsumer<AuthCubit, AuthState>(
      builder: (contexts, state) {
        if (state is LoadingSignInState) {
          return loading;
        }
        if (state is ErrorSignInState) {
          return const Text('Sign In', style: TextStyle(color: Colors.white));
        }
        if (state is SignInSuccessfuly) {
          return const Text('Sign in', style: TextStyle(color: Colors.white));
        }
        return const Text('Sign in', style: TextStyle(color: Colors.white));
      },
      listener: (context, state) {
        if (state is ErrorSignInState) {
          showToast(state.ErrorMes, Colors.red);
        }
        if (state is SignInSuccessfuly) {
          showToast('Signed In Successfuly', Colors.green);
          Navigator.pushNamed(context, '/Wrapper');
        }
      },
    );
  }

  final loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const <Widget>[
      CircularProgressIndicator(
        color: Colors.white,
      ),
      Text(
        " Login ... Please wait",
        style: TextStyle(color: Colors.white),
      )
    ],
  );
  void showToast(String message, Color color) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: color,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM);
  }
}
