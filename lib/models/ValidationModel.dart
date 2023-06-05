class ValidationModel {
  String firstName;
  String lastName;
  String email;
  String userId;
  String phoneNumber;

  ValidationModel(
      {required this.userId,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber});
}
