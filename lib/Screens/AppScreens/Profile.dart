import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../logic/Profile/Bloc.dart';
import '../../models/UserModel.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  static const String profilePath = '/Profile';

  @override
  Widget build(BuildContext context) {
    String firstName =
        '${context.read<ProfileBloc>().profile.firstName.toString()}';
    String lastName =
        '${context.read<ProfileBloc>().profile.lastName.toString()}';
    String firstLetter =
        '${context.read<ProfileBloc>().profile.firstName![0].toUpperCase()}';

    String email = '${context.read<ProfileBloc>().profile.email.toString()}';

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(firstName);
    return Scaffold(
      backgroundColor: appBackground,
      body: Stack(
        children: [
          SizedBox(
            height: height,
          ),
          Positioned(
            child: Container(
              height: height * 0.3,
              width: width,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(200.0),
                    bottomLeft: Radius.circular(200.0)),
              ),
            ),
          ),
          Positioned(
            top: 20,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Positioned(
            top: height * 0.22,
            left: width * 0.37,
            child: SizedBox(
              height: 90,
              width: 90,
              child: CircleAvatar(
                backgroundColor: buttonGrey,
                child: Text(
                  firstLetter,
                  style: const TextStyle(fontSize: 30.0, color: Colors.black),
                ), //Text
              ),
            ),
          ),
          Positioned(
              top: height * 0.4,
              left: width * 0.1,
              child: ProfileRowD(
                height: height,
                width: width,
                text: firstName,
                icon: Icons.account_circle,
              )),
          Positioned(
              top: height * 0.55,
              left: width * 0.1,
              child: ProfileRowD(
                height: height,
                width: width,
                text: lastName,
                icon: Icons.account_circle,
              )),
          Positioned(
              top: height * 0.7,
              left: width * 0.1,
              child: ProfileRowD(
                height: height,
                width: width,
                text: email,
                icon: Icons.email,
              )),
        ],
      ),
    );
  }
}

class ProfileRowD extends StatelessWidget {
  const ProfileRowD(
      {super.key,
      required this.height,
      required this.width,
      required this.text,
      required this.icon});

  final double height;
  final double width;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height * 0.1,
        width: width * 0.8,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 35,
                  ),
                  SizedBox(
                    width: width * 0.04,
                  ),
                  Text(
                    '$text',
                    style: TextStyle(color: Colors.black, fontSize: 22),
                  ),
                ],
              ),
            ),
            Spacer(),
            Divider(
              thickness: 2,
            ),
          ],
        ));
  }
}
