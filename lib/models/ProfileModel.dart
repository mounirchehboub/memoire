class ProfileModel {
  String? firstName;
  String? lastName;
  String? email;
  String? userId;
  //String email = '';
  ProfileModel(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.userId});
  ProfileModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    userId = json['userId'];
    //email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['email'] = email;
    _data['userId'] = userId;
    return _data;
  }
}
