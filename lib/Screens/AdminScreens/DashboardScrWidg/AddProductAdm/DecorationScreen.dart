import 'package:flutter/material.dart';

import '../../../../Validator.dart';

class AddPrField extends StatelessWidget {
  const AddPrField({
    required this.labelText,
    required this.onChnaged,
    required this.lines,
    required this.initial,
  });
  final int lines;
  final String labelText;
  final Function(String) onChnaged;
  final String initial;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initial,
      maxLines: lines,
      onChanged: onChnaged,
      validator: (value) {
        if (value!.isEmpty) {
          return "Complete Required Field";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
          label: Text(labelText),
          enabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(width: 1, color: Colors.black), //<-- SEE HERE
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(width: 1, color: Colors.black), //<-- SEE HERE
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.red), //<-- SEE HERE
          )),
    );
  }
}

class suffTextField extends StatelessWidget with FormValidationMixin {
  const suffTextField({
    super.key,
    required this.height,
    required this.width,
    required this.suffix,
    required this.labelText,
    required this.onChanged,
    required this.initial,
    required this.isInteger,
  });
  final bool isInteger;
  final double height;
  final double width;
  final String suffix;
  final String labelText;
  final Function(String)? onChanged;
  final String initial;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height * 0.07,
        width: width * 0.3,
        child: TextFormField(
            initialValue: initial,
            onChanged: onChanged,
            validator: isInteger ? emptyIntegerValidation : emptyValidation,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                suffix: Text(
                  suffix,
                  style: const TextStyle(color: Colors.black),
                ),
                label: Text(labelText),
                enabledBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: Colors.black), //<-- SEE HERE
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: Colors.black), //<-- SEE HERE
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: Colors.red), //<-- SEE HERE
                ))));
  }
}

class StockTextField extends StatelessWidget with FormValidationMixin {
  const StockTextField({
    super.key,
    required this.height,
    required this.width,
    required this.suffix,
    required this.labelText,
    required this.onChanged,
    required this.initial,
    required this.validator,
  });
  final String? Function(String?) validator;
  final double height;
  final double width;
  final String suffix;
  final String labelText;
  final Function(String)? onChanged;
  final String initial;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height * 0.07,
        width: width * 0.3,
        child: TextFormField(
            initialValue: initial,
            onChanged: onChanged,
            validator: validator,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                suffix: Text(
                  suffix,
                  style: const TextStyle(color: Colors.black),
                ),
                label: Text(labelText),
                enabledBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: Colors.black), //<-- SEE HERE
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: Colors.black), //<-- SEE HERE
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: Colors.red), //<-- SEE HERE
                ))));
  }
}

class CustomPasswordField extends StatelessWidget with FormValidationMixin {
  CustomPasswordField(
      {required this.labelText,
      required this.onChnaged,
      required this.onPressed,
      required this.isObscure});
  final String labelText;
  final Function(String) onChnaged;
  bool isObscure;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        onChanged: onChnaged,
        validator: passwordValidation,
        obscureText: !isObscure,
        decoration: InputDecoration(
            label: Text(labelText),
            suffixIcon: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                isObscure ? Icons.visibility : Icons.visibility_off,
                color: Colors.black,
              ),
              onPressed: onPressed,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(width: 1, color: Colors.black), //<-- SEE HERE
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(width: 1, color: Colors.black), //<-- SEE HERE
            ),
            errorBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(width: 1, color: Colors.red), //<-- SEE HERE
            )),
      ),
    );
  }
}

class ConfirmPasswordField extends StatelessWidget {
  ConfirmPasswordField({
    required this.labelText,
    required this.onChnaged,
    required this.onPressed,
    required this.isObscure,
    required this.validator,
  });
  final String labelText;
  final Function(String) onChnaged;
  bool isObscure;
  final void Function() onPressed;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        onChanged: onChnaged,
        validator: validator,
        obscureText: !isObscure,
        decoration: InputDecoration(
            label: Text(labelText),
            suffixIcon: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                isObscure ? Icons.visibility : Icons.visibility_off,
                color: Colors.black,
              ),
              onPressed: onPressed,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(width: 1, color: Colors.black), //<-- SEE HERE
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(width: 1, color: Colors.black), //<-- SEE HERE
            ),
            errorBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(width: 1, color: Colors.red), //<-- SEE HERE
            )),
      ),
    );
  }
}
