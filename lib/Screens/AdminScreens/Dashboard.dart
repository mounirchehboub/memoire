import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monirakrem/constants.dart';

import '../../logic/newProduct/Bloc.dart';
import 'DashboardScrWidg/AddProductAdm/AddProductAdm.dart';
import 'DashboardScrWidg/DeleteProduct/DeleteProductAdm.dart';
import 'DashboardScrWidg/EditProducts/EditProductAdm.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  static const String Dashboardpath = '/Dashboardpath';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: appBackground,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.04,
              ),
              Container(
                width: width,
                margin: EdgeInsets.symmetric(horizontal: width * 0.1),
                height: height * 0.1,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "Hello",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Mr. Mounir",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              DashboardContainer(
                height: height,
                width: width,
                icon: Icons.add,
                iconColor: Colors.orange,
                text: "Add new products",
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (contexts) => BlocProvider.value(
                            value: BlocProvider.of<ProduitBloc>(context),
                            child: AddProductAdm()),
                      ));
                },
              ),
              DashboardContainer(
                height: height,
                width: width,
                icon: Icons.edit,
                iconColor: Color(0xFF541FFF),
                text: "Edit product",
                ontap: () {
                  Navigator.pushNamed(
                      context, EditProductAdm.EditProductAdmPath);
                },
              ),
              DashboardContainer(
                height: height,
                width: width,
                icon: Icons.delete_rounded,
                iconColor: Color(0xffFD164C),
                text: "Delete product",
                ontap: () {
                  Navigator.pushNamed(
                      context, DeleteProductAdm.DeleteProductAdmPath);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardContainer extends StatelessWidget {
  const DashboardContainer({
    super.key,
    required this.ontap,
    required this.height,
    required this.width,
    required this.icon,
    required this.iconColor,
    required this.text,
  });
  final IconData icon;
  final Color iconColor;
  final String text;
  final double height;
  final double width;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.08,
      margin: EdgeInsets.only(
          left: width * 0.05, right: width * 0.05, bottom: height * 0.04),
      width: width,
      decoration: BoxDecoration(
        color: buttonGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: ontap,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: width * 0.08,
            ),
            Icon(
              icon,
              color: iconColor,
            ),
            SizedBox(
              width: width * 0.08,
            ),
            Text(
              text,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
