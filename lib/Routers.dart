import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monirakrem/Screens/AppScreens/Cart/Validation.dart';
import 'package:monirakrem/Screens/AppScreens/Profile.dart';
import 'package:monirakrem/Screens/Home_pages/homePage.dart';
import 'package:monirakrem/Screens/SignPages/Recovery.dart';
import 'package:monirakrem/logic/Profile/Bloc.dart';
import 'package:monirakrem/models/UserModel.dart';
import 'package:monirakrem/wrapper.dart';
import 'package:provider/provider.dart';
import 'Screens/AdminScreens/DashboardScrWidg/AddProductAdm/AddProductAdm.dart';
import 'Screens/AdminScreens/DashboardScrWidg/DeleteProduct/DeleteProductAdm.dart';
import 'Screens/AdminScreens/DashboardScrWidg/EditProducts/EditProductAdm.dart';
import 'Screens/AdminScreens/DashboardScrWidg/EditProducts/GeneralFields.dart';
import 'Screens/AdminScreens/DashboardScrWidg/EditProducts/PromotionUpdate.dart';
import 'Screens/AdminScreens/DashboardScrWidg/EditProducts/StockUpdate.dart';
import 'Screens/AdminScreens/DashboardScrWidg/One_Place.dart';
import 'Screens/AppScreens/Cart/CartScreen.dart';
import 'Screens/AppScreens/ProductDetails/ProductDetails.dart';
import 'Screens/SignPages/Signin_Page.dart';
import 'Screens/SignPages/Signup_Page.dart';
import 'logic/Auth_Cubit.dart';
import 'logic/CartNewVersion/Bloc.dart';
import 'logic/Edit/Bloc.dart';
import 'logic/LoadTen/Bloc.dart';
import 'logic/Product/Bloc.dart';

class Routerr {
  final AuthCubit authCubit = AuthCubit();
  final CartProductBloc cartProductBloc = CartProductBloc();
  Route<dynamic>? GenerateRoute(RouteSettings settings) {
    late final args = settings.arguments as ScreenArguments;
    switch (settings.name) {
      case '/SignIn':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: authCubit, child: const SigninPage()));
      case '/SignUp':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: authCubit, child: const SignupPage()));
      case '/Recovery':
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider.value(value: authCubit, child: const Recovery()));

      case '/Wrapper':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider.value(
                    value: authCubit,
                  ),
                  BlocProvider.value(
                    value: cartProductBloc,
                  ),
                ], child: Wrapper()));

      case '/ProductHome':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
            BlocProvider(create: (_) => ProductBloc()..add(ProductGetEvent())),
            BlocProvider(create: (_) => cartProductBloc),
          ], child: const ProductHome()),
        );

      case CartScreen.cartPath:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: cartProductBloc, child: const CartScreen()));

      case Validation.validationPath:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: cartProductBloc),
              ],
              child: Validation()),
        );

      case ProductDetails.ProductDetailsPath:
        final args = settings.arguments as ProductDetailArg;
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: cartProductBloc,
                  child: ProductDetails(
                    product: args.product,
                  ),
                ));

      case AddProductAdm.Addproductpath:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AddProductAdm());

      case DeleteProductAdm.DeleteProductAdmPath:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
            BlocProvider(
                create: (_) => TenProductBloc()
                  ..add(LoadTenProductEvent(TenProducts: []))),
          ], child: const DeleteProductAdm()),
        );

      case EditProductAdm.EditProductAdmPath:
        return MaterialPageRoute(builder: (_) => const EditProductAdm());

      case OnePlace.OneplacePath:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                          create: (_) => TenProductBloc()
                            ..add(LoadTenProductEvent(TenProducts: []))),
                    ],
                    child: OnePlace(
                      id: 100,
                    )));
      case GeneralFields.generalFieldsPath:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => EditBloc(),
                  child: GeneralFields(
                    product: args.product,
                  ),
                ));

      case PromotionUpdate.promotionUpdatePath:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => EditBloc(),
                  child: PromotionUpdate(
                    product: args.product,
                  ),
                ));

      case StockUpdate.stockUpdatePath:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => EditBloc(),
                  child: StockUpdate(
                    product: args.product,
                  ),
                ));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }

  void dispose() {
    authCubit.close();
  }
}

/*

case CartScreen.CartPath:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: CartBloc(),
                  child: CartScreen(),
                ));
 */

/*
 case ProductDetails.ProductDetailsPath:
        final args = settings.arguments as ProductDetailArg;
        return MaterialPageRoute(
            builder: (_) => ProductDetails(
                  product: args.product,
                ));
 */
