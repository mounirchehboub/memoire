import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../../../../Services/firebasecall/ProductAddStorage.dart';
import '../../../../constants.dart';
import '../../../../logic/newProduct/Bloc.dart';
import '../../../../models/ProductModel.dart';
import 'DecorationScreen.dart';
import 'DropDownLists.dart';
import 'RadioRow.dart';

class AddProductAdm extends StatefulWidget {
  const AddProductAdm({Key? key}) : super(key: key);
  static const String Addproductpath = "/Addproductpath";
  @override
  _AddProductAdmState createState() => _AddProductAdmState();
}

class _AddProductAdmState extends State<AddProductAdm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String category = DropDownList.categoryList.first;
  List<String> imagesPath = [];
  List<String> imagesDownloadpath = [];
  List<File> pickedImages = [];
  int isPromotion = 2;
  String Title = '', Desctiption = '';
  double? Price = 0.0;
  int Stock = 0, Promotion = 0;
  String brand = '';
  int peopleCapacity = 1, km = 0;

  ProductStorage productStorage = ProductStorage();

  setSelectedPromotion(int? value) {
    setState(() {
      isPromotion = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Widget space = SizedBox(
      height: height * 0.04,
    );
    final Widget spacetwo = SizedBox(
      height: height * 0.02,
    );

    return Scaffold(
      backgroundColor: appBackground,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.1,
                  ),
                  const Text(
                    "Photos - 0/05 - You can add up to 5 photos",
                    style: TextStyle(color: Color(0xff444444)),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      child: imagesPath.isEmpty
                          ? FormField(
                              validator: (value) {
                                if (value == null) {
                                  return 'Pick a picture';
                                }
                              },
                              builder: (formFieldState) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    beforeAdded(height, width),
                                    if (formFieldState.hasError)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, top: 10),
                                        child: Text(
                                          formFieldState.errorText!,
                                          style: TextStyle(
                                              fontStyle: FontStyle.normal,
                                              fontSize: 13,
                                              color: Colors.red[700],
                                              height: 0.5),
                                        ),
                                      )
                                  ],
                                );
                              },
                            )
                          : Row(
                              children: [
                                Images(height, width),
                                workimages(context, height, width)
                              ],
                            ),
                    ),
                  ),
                  space,
                  AddPrField(
                    initial: '',
                    lines: 1,
                    labelText: "Title",
                    onChnaged: (value) {
                      setState(() {
                        Title = value;
                      });
                    },
                  ),
                  space,
                  AddPrField(
                    initial: '',
                    lines: 8,
                    labelText: "Description",
                    onChnaged: (value) {
                      setState(() {
                        Desctiption = value;
                      });
                    },
                  ),
                  spacetwo,
                  AddPrField(
                    initial: '',
                    lines: 1,
                    labelText: "Brand",
                    onChnaged: (value) {
                      setState(() {
                        brand = value;
                      });
                    },
                  ),
                  spacetwo,
                  const Text(
                    "Select category",
                    style: TextStyle(color: Color(0xFF444444)),
                  ),
                  spacetwo,
                  Container(
                    width: width,
                    height: height * 0.07,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: buttonGrey,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<String>(
                          validator: (value) {
                            if (value == null) {
                              return "category is required";
                            } else {
                              return null;
                            }
                          },
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                          isExpanded: true,
                          items: DropDownList.categoryList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: category,
                          onChanged: (String? selectedValue) {
                            setState(() {
                              category = selectedValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  space,
                  Row(
                    children: [
                      suffTextField(
                        initial: '',
                        onChanged: (value) {
                          setState(() {
                            Price = double.tryParse(value);
                          });
                        },
                        height: height,
                        width: width,
                        suffix: '\$',
                        labelText: 'Price',
                        isInteger: false,
                      ),
                      const Spacer(),
                      suffTextField(
                        initial: '',
                        onChanged: (value) {
                          setState(() {
                            Stock = int.tryParse(value)!.toInt();
                          });
                        },
                        height: height,
                        width: width,
                        suffix: 'Pcs',
                        labelText: 'Stock',
                        isInteger: true,
                      ),
                    ],
                  ),
                  spacetwo,
                  Row(
                    children: [
                      suffTextField(
                        initial: '',
                        onChanged: (value) {
                          setState(() {
                            peopleCapacity = int.tryParse(value)!.toInt();
                          });
                        },
                        height: height,
                        width: width,
                        suffix: 'N°',
                        labelText: 'PeopleNumber',
                        isInteger: false,
                      ),
                      const Spacer(),
                      suffTextField(
                        initial: '',
                        onChanged: (value) {
                          setState(() {
                            km = int.tryParse(value)!.toInt();
                          });
                        },
                        height: height,
                        width: width,
                        suffix: 'KM',
                        labelText: 'Speed',
                        isInteger: true,
                      ),
                    ],
                  ),
                  spacetwo,
                  RowRadioButton(
                    width: width,
                    selectedNew: isPromotion,
                    text: "isPromotion  ",
                    onChanged: (val) {
                      print(val);
                      setSelectedPromotion(val);
                    },
                  ),
                  isPromotion == 1
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: suffTextField(
                            initial: '',
                            onChanged: (value) {
                              setState(() {
                                Promotion = int.tryParse(value)!.toInt();
                                print(Promotion);
                              });
                            },
                            height: height,
                            width: width,
                            suffix: '%',
                            labelText: 'Promotion',
                            isInteger: true,
                          ),
                        )
                      : Container(),
                  space,
                  Container(
                    width: width * 0.4,
                    child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orange),
                        ),
                        onPressed: () async {
                          bool promo = numbertobool(isPromotion);
                          if (_formKey.currentState!.validate()) {
                            List<String> downloadUrls = await productStorage
                                .uploadImages(pickedImages, Title);

                            Product product = Product(
                              promotion: Promotion,
                              productId: "Apple",
                              stock: Stock,
                              images: downloadUrls,
                              title: Title,
                              price: Price!.toDouble(),
                              description: Desctiption,
                              category: category,
                              isPromo: promo,
                              brand: brand,
                              km: km,
                              peopleCapacity: peopleCapacity,
                            );

                            BlocProvider.of<ProduitBloc>(context)
                                .add(ProduitAddEvent(product: product));
                            print(imagesDownloadpath);
                          }
                        },
                        child: builBlocBuilder()),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool numbertobool(int number) {
    if (number == 1) {
      return true;
    }
    return false;
  }

  Widget builBlocBuilder() {
    return BlocConsumer<ProduitBloc, ProduitState>(
      builder: (context, state) {
        if (state is LoadingProduitState) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
        return const Text(
          'Submit',
          style: TextStyle(color: Colors.white),
        );
      },
      listener: (context, state) {
        if (state is LoadedProduitState) {
          showToast('Product Added Successfuly', Colors.green);
          Navigator.pushNamed(context, '/Wrapper');
        }
        if (state is FailedLoadingProduitState) {
          showToast(state.error, Colors.red);
        }
      },
    );
  }

  Future selectImage(ImageSource source) async {
    final image = await ImagePicker.platform.pickImage(source: source);
    if (image == null) return;
    final path = image.path;
    setState(() {
      if (!imagesPath.contains(path)) {
        pickedImages.add(File(path));
        imagesPath.add(path);
      }
    });
  }

  Widget workimages(BuildContext context, double height, double width) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: ((builder) => bottomsheet()),
        );
      },
      child: Container(
        height: height * 0.15,
        width: width * 0.30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: buttonGrey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.my_library_add,
              color: Colors.grey,
            ),
            SizedBox(
              height: height * 0.01,
            ),
            const Text(
              "Add photo",
              style: TextStyle(color: textGrey),
            )
          ],
        ),
      ),
    );
  }

  Widget Images(double height, double width) {
    return SizedBox(
      height: height * 0.15,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: imagesPath.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Container(
                    margin: EdgeInsets.only(right: width * 0.04),
                    height: height * 0.15,
                    width: width * 0.30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: buttonGrey,
                    ),
                    child: Center(
                      child: Image.file(
                        File(imagesPath[index]),
                        fit: BoxFit.cover,
                      ),
                    )),
                Positioned(
                    top: height * 0.008,
                    right: width * 0.05,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          imagesPath.removeAt(index);
                          pickedImages.removeAt(index);
                          print(pickedImages);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    )),
              ],
            );
          }),
    );
  }

  Widget bottomsheet() {
    return Container(
      height: 150.0,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          const Text(
            'Choose Profile Photo',
            style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(
            height: 25.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                  onPressed: () {
                    selectImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text('Camera')),
              const SizedBox(
                width: 10,
              ),
              TextButton.icon(
                  onPressed: () {
                    selectImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('Gallery')),
            ],
          )
        ],
      ),
    );
  }

  Widget beforeAdded(double height, double width) {
    return InkWell(
        onTap: () {
          showModalBottomSheet(
              context: context, builder: ((builder) => bottomsheet()));
        },
        child: Container(
          height: height * 0.15,
          width: width - width * 0.08,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.transparent,
              border: Border.all(color: textGrey, width: 1.5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.my_library_add,
                color: Colors.orange,
              ),
              SizedBox(
                height: height * 0.01,
              ),
              const Text(
                "Add photos",
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
        ));
  }
}
