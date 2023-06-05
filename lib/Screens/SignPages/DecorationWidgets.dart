import 'package:flutter/material.dart';

import '../../Validator.dart';

class CustomTextField extends StatelessWidget with FormValidationMixin {
  const CustomTextField({
    super.key,
    required this.textController,
    required this.height,
    required this.width,
    required this.hint,
  });

  final TextEditingController? textController;
  final double height;
  final double width;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.name,
      validator: emptyValidation,
      autofocus: false,
      controller: textController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
        hintText: hint,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: Colors.black),
            borderRadius: BorderRadius.circular(10) //<-- SEE HERE
            ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: Colors.black),
            borderRadius: BorderRadius.circular(10) //<-- SEE HERE
            ),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: Colors.red),
            borderRadius: BorderRadius.circular(10) //<-- SEE HERE
            ),
      ),
    );
  }
}

class CustomEmailTextField extends StatelessWidget with FormValidationMixin {
  const CustomEmailTextField({
    super.key,
    required this.emailController,
    required this.height,
    required this.width,
  });

  final TextEditingController? emailController;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: emailValidation,
      autofocus: false,
      controller: emailController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
        hintText: "abc@gmail.com",
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: Colors.black),
            borderRadius: BorderRadius.circular(10) //<-- SEE HERE
            ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: Colors.black),
            borderRadius: BorderRadius.circular(10) //<-- SEE HERE
            ),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: Colors.red),
            borderRadius: BorderRadius.circular(10) //<-- SEE HERE
            ),
      ),
    );
  }
}

class CustomPasswordTextField extends StatelessWidget with FormValidationMixin {
  const CustomPasswordTextField({
    super.key,
    required this.controller,
    required this.height,
    required this.width,
    required this.isObscure,
    required this.onPressed,
  });

  final TextEditingController? controller;
  final double height;
  final double width;
  final bool isObscure;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !isObscure,
      validator: passwordValidation,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: "password",
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            isObscure ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
          ),
          onPressed: onPressed,
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(10) //<-- SEE HERE
            ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(10) //<-- SEE HERE
            ),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.red),
            borderRadius: BorderRadius.circular(10) //<-- SEE HERE
            ),
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}

class CustomField extends StatelessWidget with FormValidationMixin {
  const CustomField({
    super.key,
    required this.textController,
    required this.height,
    required this.width,
    required this.hint,
  });

  final TextEditingController? textController;
  final double height;
  final double width;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      validator: emptyPermisValidation,
      autofocus: false,
      controller: textController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: hint,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: Colors.black),
            borderRadius: BorderRadius.circular(10) //<-- SEE HERE
            ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: Colors.black),
            borderRadius: BorderRadius.circular(10) //<-- SEE HERE
            ),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: Colors.red),
            borderRadius: BorderRadius.circular(10) //<-- SEE HERE
            ),
      ),
    );
  }
}

class CustomPhoneField extends StatelessWidget with FormValidationMixin {
  const CustomPhoneField({
    super.key,
    required this.textController,
    required this.height,
    required this.width,
    required this.hint,
  });

  final TextEditingController? textController;
  final double height;
  final double width;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      validator: emptyPhoneValidation,
      autofocus: false,
      controller: textController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: hint,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: Colors.black),
            borderRadius: BorderRadius.circular(10) //<-- SEE HERE
            ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: Colors.black),
            borderRadius: BorderRadius.circular(10) //<-- SEE HERE
            ),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: Colors.red),
            borderRadius: BorderRadius.circular(10) //<-- SEE HERE
            ),
      ),
    );
  }
}
