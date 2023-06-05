import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monirakrem/constants.dart';

import '../../../../logic/LoadTen/Bloc.dart';
import '../../../../logic/Search/Bloc.dart';
import '../One_Place.dart';

class EditProductAdm extends StatefulWidget {
  const EditProductAdm({Key? key}) : super(key: key);
  static const String EditProductAdmPath = "/EditProductAdmPath";

  @override
  _EditProductAdmState createState() => _EditProductAdmState();
}

class _EditProductAdmState extends State<EditProductAdm> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Widget space = SizedBox(
      height: height * 0.04,
    );
    return Scaffold(
      backgroundColor: appBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
                const Center(
                  child: Text(
                    "Edit your Products",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                space,
                EditBlock(
                  height: height,
                  width: width,
                  text: 'Edit General fields',
                  icon: Icons.edit,
                  color: const Color(0xFF541FFF),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider(
                                          create: (_) => TenProductBloc()
                                            ..add(LoadTenProductEvent(
                                                TenProducts: []))),
                                      BlocProvider(create: (_) => SearchBloc()),
                                    ],
                                    child: const OnePlace(
                                      id: 1,
                                    ))));
                  },
                ),
                space,
                EditBlock(
                  height: height,
                  width: width,
                  text: 'Add/Remove Promotion',
                  icon: CupertinoIcons.cart,
                  color: Colors.red,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider(
                                          create: (_) => TenProductBloc()
                                            ..add(LoadTenProductEvent(
                                                TenProducts: []))),
                                      BlocProvider(create: (_) => SearchBloc()),
                                    ],
                                    child: const OnePlace(
                                      id: 2,
                                    ))));
                  },
                ),
                space,
                EditBlock(
                  height: height,
                  width: width,
                  text: 'Update Stock',
                  icon: CupertinoIcons.tray_arrow_down_fill,
                  color: Colors.green,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider(
                                          create: (_) => TenProductBloc()
                                            ..add(LoadTenProductEvent(
                                                TenProducts: []))),
                                      BlocProvider(create: (_) => SearchBloc()),
                                    ],
                                    child: const OnePlace(
                                      id: 3,
                                    ))));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditBlock extends StatelessWidget {
  const EditBlock({
    super.key,
    required this.height,
    required this.width,
    required this.text,
    required this.icon,
    required this.color,
    required this.onTap,
  });
  final String text;
  final IconData icon;
  final double height;
  final double width;
  final Color color;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height * 0.12,
        width: width,
        decoration: BoxDecoration(
          color: buttonGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            SizedBox(
              width: width * 0.03,
            ),
            Icon(
              icon,
              color: color,
            ),
            SizedBox(
              width: width * 0.03,
            ),
            Text(
              text,
              style: TextStyle(
                  color: Color(0xff444444), fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
