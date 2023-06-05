part of 'Bloc.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialProfileState extends ProfileState {}

class LoadingProfileState extends ProfileState {}

class LoadedProfileState extends ProfileState {}

class NoUserState extends ProfileState {}

class FailedProfileState extends ProfileState {
  final String errorMessage;
  FailedProfileState({required this.errorMessage});
}
