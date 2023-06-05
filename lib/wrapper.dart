import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monirakrem/Screens/Home_pages/homePage.dart';
import 'package:monirakrem/logic/Auth_Cubit.dart';
import 'package:monirakrem/logic/CartNewVersion/Bloc.dart';
import 'package:monirakrem/logic/Product/Bloc.dart';
import 'package:provider/provider.dart';

import 'Screens/SignPages/Signin_Page.dart';
import 'logic/Profile/Bloc.dart';
import 'models/UserModel.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);
  final ProfileBloc profileBloc = ProfileBloc();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);

    if (user == Users("", false)) {
      return BlocProvider(
          create: (_) => AuthCubit(), child: const SigninPage());
    } else {
      print(user.Uuid);
      return MultiBlocProvider(providers: [
        BlocProvider(create: (_) => ProductBloc()..add(ProductGetEvent())),
        BlocProvider.value(value: context.read<CartProductBloc>()),
        BlocProvider(
          create: (context) =>
              profileBloc..add(LoadProfileEvent(ProfileId: user.Uuid)),
        ),
      ], child: ProductHome());
    }
  }
}
