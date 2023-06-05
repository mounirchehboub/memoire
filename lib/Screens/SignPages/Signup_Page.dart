import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants.dart';
import '../../logic/Auth_Cubit.dart';
import 'DecorationWidgets.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  FToast fToast = FToast();
  var _fromkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  bool hidden = false;
  void showToast(String message, Color color) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: color,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM);
  }

  String firstName = '', lastName = '', email = '', password = '';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: appBackground,
        leading: IconButton(
          highlightColor: Colors.transparent,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/SignIn');
          },
        ),
      ),
      backgroundColor: appBackground,
      body: Form(
        key: _fromkey,
        child: ListView(
          children: [
            SizedBox(
              height: height * 0.03,
            ),
            const Center(
              child: Text(
                "Create Account",
                style: TextStyle(color: textColor, fontSize: 28),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            const Center(
              child: Text(
                "Let's Create Account Together",
                style: TextStyle(color: textGreyColor, fontSize: 16),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.025),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'First name',
                    style: TextStyle(color: textColor, fontSize: 16),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  CustomTextField(
                      textController: firstnameController,
                      height: height,
                      width: width,
                      hint: 'first Name'),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  const Text(
                    'Last name',
                    style: TextStyle(color: textColor, fontSize: 16),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  CustomTextField(
                    textController: lastnameController,
                    height: height,
                    width: width,
                    hint: 'Last Name',
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  const Text(
                    'email',
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
                  const Text(
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
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 05.0),
                    child: Container(
                      width: width,
                      height: height * 0.08,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: buttonColor),
                      child: TextButton(
                        onPressed: () async {
                          if (_fromkey.currentState!.validate()) {
                            print(
                                'FirstName is ${firstnameController!.text} , LastName is ${lastnameController!.text}, email is ${emailController!.text} , password is ${passwordController!.text} ');
                            await BlocProvider.of<AuthCubit>(context).SignUp(
                                firstnameController!.text,
                                lastnameController!.text,
                                emailController!.text,
                                passwordController!.text);
                          }
                        },
                        child: buildSignUp(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/SignIn');
                        },
                        child: const Text.rich(TextSpan(
                          text: 'Already have an account',
                          style: TextStyle(color: textGreyColor, fontSize: 14),
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'Sign in',
                              style: TextStyle(color: textColor, fontSize: 14),
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

  final loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const <Widget>[
      CircularProgressIndicator(
        color: Colors.white,
      ),
      Text(
        " Regestering ... Please wait",
        style: TextStyle(color: Colors.white),
      )
    ],
  );

  Widget buildSignUp() {
    return BlocConsumer<AuthCubit, AuthState>(builder: (contexts, state) {
      if (state is LoadingRegesteringState) {
        return loading;
      }
      if (state is ErrorRegesteringState) {
        return const Text('Sign Up', style: TextStyle(color: Colors.white));
      }
      if (state is UserRegisteredState) {
        return const Text('Sign Up', style: TextStyle(color: Colors.white));
      }
      return const Text('Sign Up', style: TextStyle(color: Colors.white));
    }, listener: (context, state) {
      if (state is UserRegisteredState) {
        showToast('Registered Successfuly', Colors.green);
        Navigator.pushNamed(context, '/SignIn');
      }
      if (state is ErrorRegesteringState) {
        showToast(state.ErrorMes, Colors.red);
      }
    });
  }
}
