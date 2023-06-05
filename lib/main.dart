import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monirakrem/logic/Auth_Cubit.dart';
import 'package:monirakrem/logic/CartNewVersion/Bloc.dart';
import 'package:monirakrem/logic/Profile/Bloc.dart';
import 'package:monirakrem/models/UserModel.dart';
import 'package:provider/provider.dart';

import 'Routers.dart';
import 'logic/Search/Bloc.dart';
import 'logic/newProduct/Bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Routerr appRouter = Routerr();
    return StreamProvider<Users>.value(
      initialData: Users('', false),
      value: AuthCubit().user,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ProduitBloc()),
          BlocProvider(create: (context) => SearchBloc()),
          BlocProvider(create: (context) => ProfileBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Nroul fi bledi',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/Wrapper',
          onGenerateRoute: appRouter.GenerateRoute,
        ),
      ),
    );
  }
}
