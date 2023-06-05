part of 'Bloc.dart';

abstract class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent {
  String ProfileId;
  LoadProfileEvent({required this.ProfileId});
}
