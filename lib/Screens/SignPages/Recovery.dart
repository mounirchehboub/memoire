import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:monirakrem/constants.dart';

import '../../logic/Auth_Cubit.dart';
import 'DecorationWidgets.dart';

class Recovery extends StatefulWidget {
  const Recovery({Key? key}) : super(key: key);

  @override
  _RecoveryState createState() => _RecoveryState();
}

class _RecoveryState extends State<Recovery> {
  var _fromkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  FToast fToast = FToast();
  void showToast(String message, Color color) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: color,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: appBackground,
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
      body: Form(
        key: _fromkey,
        child: ListView(
          children: [
            SizedBox(
              height: height * 0.03,
            ),
            const Center(
              child: Text(
                "Recovery Password",
                style: TextStyle(color: textColor, fontSize: 28),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            const Center(
              child: Text(
                "Please enter your email address to recieve a verification code",
                textAlign: TextAlign.center,
                style: TextStyle(color: textGreyColor, fontSize: 16),
              ),
            ),
            SizedBox(
              height: height * 0.1,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.025),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                          //await BlocProvider.of<AuthCubit>(context)
                          //                               .recovery(email: emailController!.text);
                        }
                      },
                      child: buildConsumer(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildConsumer() {
    return BlocConsumer<AuthCubit, AuthState>(builder: (context, state) {
      if (state is LoadingReset) {
        return const Center(
            child: CircularProgressIndicator(
          strokeWidth: 2.0,
          color: Colors.white,
        ));
      }
      return const Text('Continue', style: TextStyle(color: Colors.white));
    }, listener: (context, state) {
      if (state is ResetSuccess) {
        showToast(
            'We have sent you reset email to your email address', Colors.green);
      }
      if (state is ErrorResetState) {
        showToast(state.ErrorMes, Colors.red);
      }
    });
  }
}
