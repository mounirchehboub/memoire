import 'package:equatable/equatable.dart';

class Users extends Equatable {
  String Uuid;
  bool isEmailVerified;

  Users(this.Uuid, this.isEmailVerified);

  @override
  // TODO: implement props
  List<Object?> get props => [Uuid, isEmailVerified];
}
