import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monirakrem/Screens/AdminScreens/Dashboard.dart';
import 'package:monirakrem/Screens/AppScreens/Cart/CartScreen.dart';
import 'package:monirakrem/constants.dart';
import 'package:monirakrem/logic/Auth_Cubit.dart';
import 'package:monirakrem/logic/CartNewVersion/Bloc.dart';
import 'package:monirakrem/logic/Profile/Bloc.dart';
import 'package:monirakrem/models/CartModel.dart';

import '../AppScreens/Profile.dart';

class DrawerA extends StatelessWidget {
  const DrawerA({
    super.key,
    required this.profileBloc,
  });
  final ProfileBloc profileBloc;
  @override
  Widget build(BuildContext context) {
    String fullName = '${profileBloc.profile.firstName.toString()}'
        '\t ${profileBloc.profile.lastName.toString()}';
    String firstLetter = '${profileBloc.profile.firstName![0].toUpperCase()}';
    String email = '${profileBloc.profile.email.toString()}';
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: buttonColor,
            ), //BoxDecoration
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: buttonColor),
              accountName: Text(
                fullName,
                style: const TextStyle(fontSize: 18),
              ),
              accountEmail: Text(email),
              currentAccountPictureSize: const Size.square(50),
              currentAccountPicture: CircleAvatar(
                backgroundColor: buttonGrey,
                child: Text(
                  firstLetter,
                  style: const TextStyle(fontSize: 30.0, color: Colors.black),
                ), //Text
              ), //circleAvatar
            ), //UserAccountDrawerHeader
          ), //DrawerHeader

          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Cart'),
            onTap: () {
              Navigator.pushNamed(context, CartScreen.cartPath);
            },
          ),
          profileBloc.profile.userId == 'gPwnByj3r6ZyekWGkvKWlkxSxQE2'
              ? ListTile(
                  leading: const Icon(Icons.book),
                  title: const Text('Dashboard'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Dashboard()));
                  },
                )
              : const SizedBox(),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile '),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                          value: context.read<ProfileBloc>(),
                          child: const Profile())));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('LogOut'),
            onTap: () {
              context.read<CartProductBloc>().cartProducts = [];
              BlocProvider.of<AuthCubit>(context).SignOut();
            },
          ),
        ],
      ),
    );
  }

  Widget buildSignOut() {
    return BlocListener<AuthCubit, AuthState>(
      listener: ((context, state) {
        if (state is SignOutSuccessful) {
          showToast('Sign out Success ! ', Colors.green);
          Navigator.pushNamed(context, '/SignIn');
        }
        if (state is FailedSignOut) {
          showToast(state.errorMessage, Colors.red);
        }
      }),
    );
  }
}

/*
 trailing: Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.red),
              child: Center(
                child: Text(
                  '${cart.length}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
 */
