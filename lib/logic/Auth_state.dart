part of 'Auth_Cubit.dart';

@immutable
abstract class AuthState {}

class InitialAuthState extends AuthState {}

class LoadingSignInState extends AuthState {}

class ErrorSignInState extends AuthState {
  String ErrorMes;
  ErrorSignInState(this.ErrorMes);
}

class SignInSuccessfuly extends AuthState {
  Users user;
  SignInSuccessfuly(this.user);
}

class UserRegisteredState extends AuthState {}

class LoadingRegesteringState extends AuthState {}

class ErrorRegesteringState extends AuthState {
  String ErrorMes;
  ErrorRegesteringState(this.ErrorMes);
}

class LoadingReset extends AuthState {}

class ResetSuccess extends AuthState {}

class ErrorResetState extends AuthState {
  String ErrorMes;
  ErrorResetState(this.ErrorMes);
}

class LoadingSignOutStat extends AuthState {}

class SignOutSuccessful extends AuthState {}

class FailedSignOut extends AuthState {
  String errorMessage;
  FailedSignOut({required this.errorMessage});
}
