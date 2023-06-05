import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monirakrem/Screens/SignPages/DecorationWidgets.dart';
import 'package:http/http.dart' as http;
import 'package:monirakrem/logic/Profile/Bloc.dart';
import 'package:monirakrem/models/ProfileModel.dart';
import 'package:monirakrem/models/ValidationModel.dart';
import '../../../constants.dart';
import '../../../logic/CartNewVersion/Bloc.dart';
import '../../../models/CartModel.dart';

class Validation extends StatefulWidget {
  const Validation({
    Key? key,
  }) : super(key: key);
  static const String validationPath = '/Validation';

  @override
  _ValidationState createState() => _ValidationState();
}

class _ValidationState extends State<Validation> {
  @override
  void dispose() {
    // TODO: implement dispose
    phoneNumberController.dispose();
    drivingLicenceControlelr.dispose();
    cartNationalController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController drivingLicenceControlelr = TextEditingController();
  TextEditingController cartNationalController = TextEditingController();

  String emailBody = '';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isScott = context.read<CartProductBloc>().isScotter;
    bool isPermisRequired = context.read<CartProductBloc>().permisRequired;

    String totalPrice =
        BlocProvider.of<CartProductBloc>(context).TotalPrice.toStringAsFixed(2);
    String? userId = context.read<ProfileBloc>().profile.userId;
    print('$userId yeeeeeeeeeeeeeeee');
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: appBackground,
        appBar: AppBar(
          backgroundColor: appBackground,
          title: const Text(
            'Validation',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.02),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              CustomPhoneField(
                  width: width,
                  height: height,
                  textController: phoneNumberController,
                  hint: 'Phone N°'),
              SizedBox(
                height: height * 0.05,
              ),
              isPermisRequired
                  ? CustomField(
                      width: width,
                      height: height,
                      textController: drivingLicenceControlelr,
                      hint: 'Driving Licence N°')
                  : const SizedBox(),
              SizedBox(
                height: height * 0.05,
              ),
              isScott
                  ? CustomField(
                      width: width,
                      height: height,
                      textController: cartNationalController,
                      hint: 'National Cart N°')
                  : const SizedBox(),

              //TODO : Complete this form then send an email then fix validation of time and complete UI
              const Spacer(),
              Center(
                child: SizedBox(
                  height: 56,
                  width: width * 0.6,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      primary: Colors.white,
                      backgroundColor: buttonColor,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //TODO : send email
                        context.read<CartProductBloc>().add(
                            SubmitValidationEvent(
                                phoneNumber: phoneNumberController.text,
                                permisNumber: drivingLicenceControlelr.text,
                                cartIdNumber: cartNationalController.text));
                      }
                    },
                    child: validatoinConsumer(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget validatoinConsumer(BuildContext contexts) {
    return BlocConsumer<CartProductBloc, CartProductState>(
        bloc: contexts.read<CartProductBloc>(),
        builder: (context, state) {
          print(state);
          if (state is Submitting) {
            return const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2.0,
            );
          }
          return const Text(
            'Add to Cart',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          );
        },
        listener: (context, state) {
          print(state);
          if (state is SubmitSucssessful) {
            showToast('Order Submitted Sucssessfully ', Colors.green);
            contexts.read<CartProductBloc>().cartProducts = [];
            contexts.read<CartProductBloc>().isScotter = false;
            Navigator.pushNamed(context, '/Wrapper');
          }
          if (state is ErrorSubmit) {
            showToast(state.error, Colors.red);
          }
        });
  }
}

/*

Text(context.read<ProfileBloc>().profile.firstName.toString()),
            SizedBox(
              height: height * 0.05,
            ),
            Text(context.read<ProfileBloc>().profile.lastName.toString()),
            SizedBox(
              height: height * 0.05,
            ),
 */

/*
 CustomField(
                width: width,
                height: height,
                textController: phoneNumberController,
                hint: 'Phone N°'),
            SizedBox(
              height: height * 0.05,
            ),
            CustomField(
                width: width,
                height: height,
                textController: drivingLicenceControlelr,
                hint: 'Driving Licence N°'),
 */

/*
final message = Message()
    ..from = Address(username, 'Your name')
    ..recipients.add('destination@example.com')
    ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    ..bccRecipients.add(Address('bccAddress@example.com'))
    ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }

 */

/*
Email send_email = Email(
                      body: emailBody,
                      subject: 'A commande from MounirRent',
                      recipients: ['superkonan9@gmail.com'],
                      cc: ['johnkorea@gmail.com'],
                      isHTML: false,
                    );

                    await FlutterEmailSender.send(send_email);


 */

// service Id : service_jhgv7fm
