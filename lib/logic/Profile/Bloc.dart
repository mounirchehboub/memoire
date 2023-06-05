import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Services/SharedPrefrences/SharedPrefrencesService.dart';
import '../../Services/firebasecall/profilefirebase.dart';
import '../../models/ProfileModel.dart';

part 'State.dart';
part 'Event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(InitialProfileState()) {
    on<LoadProfileEvent>(_onLoadProfile);
  }
  ProfileModel profile =
      ProfileModel(firstName: 'A', lastName: 'B', email: '', userId: '');
  Future<void> _onLoadProfile(
      LoadProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(LoadingProfileState());
      profile = await FirebaseCalls(uid: event.ProfileId).getProfileData();
      print(profile.firstName.toString());
      SharedPref sharedPref = await SharedPref.getInstance();
      await sharedPref.setUserId(profile.userId.toString());
      await sharedPref.setFirstName(profile.firstName.toString());
      await sharedPref.setLastName(profile.lastName.toString());
      await sharedPref.setEmail(profile.email.toString());
      String? email = await sharedPref.getEmail();
      print(email);
      if (profile.firstName != null || profile.firstName == 'A') {
        emit(NoUserState());
      }
      emit(LoadedProfileState());
    } catch (error) {
      emit(FailedProfileState(errorMessage: error.toString()));
    }
  }
}
