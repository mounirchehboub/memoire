mixin FormValidationMixin {
  String? emptyValidation(String? value) {
    if (value == null || value.toString().trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? emptyPermisValidation(String? value) {
    if (value == null || value.toString().trim().isEmpty) {
      return 'This field is required';
    }
    if (value.length != 18) {
      return 'should be 18 numbers';
    }
    return null;
  }

  String? emptyPhoneValidation(String? value) {
    if (value == null || value.toString().trim().isEmpty) {
      return 'This field is required';
    }
    if (value.length != 10) {
      return 'should be 10 numbers';
    }
    return null;
  }

  String? emptyIntegerValidation(String? value) {
    if (value == null || value.toString().trim().isEmpty) {
      return 'Complete Field';
    } else if (value.contains('.')) {
      return 'integer';
    }
    return null;
  }

  String? passwordValidation(String? value) {
    if (value == null || value.toString().trim().isEmpty) {
      return 'This field is required';
    }
    if (value.toString().length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? emailValidation(String? value) {
    if (value == null || value.toString().trim().isEmpty) {
      return 'This field is required';
    }
    final regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    bool validEmail = regex.hasMatch(value.toString());
    if (!validEmail) {
      return 'Please enter a valid email addresse';
    }
    return null;
  }
}
