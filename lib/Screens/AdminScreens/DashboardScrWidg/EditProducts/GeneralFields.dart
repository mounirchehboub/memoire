import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monirakrem/constants.dart';

import '../../../../Services/firebasecall/ProductAddStorage.dart';
import '../../../../logic/Edit/Bloc.dart';
import '../../../../models/ProductModel.dart';
import '../AddProductAdm/DecorationScreen.dart';
import '../AddProductAdm/DropDownLists.dart';
import '../AddProductAdm/RadioRow.dart';

class GeneralFields extends StatefulWidget {
  const GeneralFields({super.key, required this.product});

  static const String generalFieldsPath = '/generalFieldsPath';
  final Product product;
  @override
  _GeneralFieldsState createState() => _GeneralFieldsState();
}

class _GeneralFieldsState extends State<GeneralFields> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ProductStorage productStorage = ProductStorage();

  int transfarBoolToInt(bool value) {
    if (value == true) {
      return 1;
    }
    return 2;
  }

  List<File> pickedImages = [];

  List<String> imagesDownloadpath = [];
  late List<String> imagesPath;
  late String category;
  late int isPromotion;

  late String Title;
  late String Desctiption;
  late double? Price;
  late int Stock, Promotion;
  late String brand;
  late int peopleCapacity, km;
  @override
  void initState() {
    // TODO: implement initState
    Title = widget.product.title;
    Desctiption = widget.product.description;
    Price = widget.product.price;
    Stock = widget.product.stock;
    Promotion = widget.product.promotion;
    imagesPath = widget.product.images;
    category = widget.product.category;
    brand = widget.product.brand;
    peopleCapacity = widget.product.peopleCapacity;
    km = widget.product.km;
    isPromotion = transfarBoolToInt(widget.product.isPromo);

    complete(widget.product.images.length, 5);
    super.initState();
  }

  late List<int> network = [];
  complete(int length, int maxLen) {
    for (int a = 0; a < length; a++) {
      network.insert(a, 1);
    }
    for (length; length < maxLen; length++) {
      network.insert(length, 0);
    }
  }

  int newIndex = -1;

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
                    height: height * 0.03,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    'Photos - ${imagesPath.length}/5 - You can add up to 5 photos',
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
                                imagesPath.length < 5
                                    ? workimages(context, height, width)
                                    : Container()
                              ],
                            ),
                    ),
                  ),
                  space,
                  AddPrField(
                    initial: widget.product.title,
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
                    initial: widget.product.description,
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
                    initial: widget.product.brand,
                    lines: 8,
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
                          value: category.isEmpty
                              ? DropDownList.categoryList.first
                              : category,
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
                        initial: widget.product.price.toString(),
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
                      Spacer(),
                      suffTextField(
                        initial: widget.product.stock.toString(),
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
                  space,
                  Row(
                    children: [
                      suffTextField(
                        initial: widget.product.peopleCapacity.toString(),
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
                        initial: widget.product.km.toString(),
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
                  space,
                  RowRadioButton(
                    width: width,
                    selectedNew: isPromotion,
                    text: "isPromotion  ",
                    onChanged: (val) {
                      setState(() {
                        isPromotion = val!;
                      });
                    },
                  ),
                  isPromotion == 1
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: suffTextField(
                            initial: widget.product.promotion.toString(),
                            onChanged: (value) {
                              setState(() {
                                Promotion = int.tryParse(value)!.toInt();
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
                          setState(() {
                            if (isPromotion == 2) {
                              Promotion = 0;
                            }
                          });
                          bool promo = numbertobool(isPromotion);
                          if (_formKey.currentState!.validate()) {
                            List<String> downloadUrls = await productStorage
                                .uploadImages(pickedImages, Title);

                            Map<String, dynamic> updateMap = {
                              "category": category,
                              "description": Desctiption,
                              "images": pickedImages.isEmpty
                                  ? imagesPath
                                  : downloadUrls,
                              "isPromo": promo,
                              "price": Price,
                              "promotion": Promotion,
                              "stock": Stock,
                              "title": Title,
                              "brand": brand,
                              "peopleCapacity": peopleCapacity,
                              "km": km
                            };

                            BlocProvider.of<EditBloc>(context).add(
                                UpdateGeneralFieldsEvent(
                                    uid: widget.product.productId,
                                    data: updateMap));
                          }
                        },
                        child: widgetbuildBloc()),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget widgetbuildBloc() {
    return BlocConsumer<EditBloc, EditProductState>(builder: (context, state) {
      if (state is LoadingGeneralFieldsUpdateState) {
        return const Center(
            child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ));
      }

      return const Text(
        'Update',
        style: TextStyle(color: Colors.white),
      );
    }, listener: (context, state) {
      if (state is LoadedGeneralFieldsUpdateState) {
        Fluttertoast.showToast(
            msg: 'Updated Successfuly ',
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM);
        Navigator.of(context).pop();
      }
      if (state is FailedGeneralFieldsUpdateState) {
        Fluttertoast.showToast(
            msg: state.errorMessage,
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM);
      }
    });
  }

  bool numbertobool(int number) {
    if (number == 1) {
      return true;
    }
    return false;
  }

  Future selectImage(ImageSource source) async {
    final image = await ImagePicker.platform.pickImage(source: source);
    if (image == null) return;
    final path = image.path;
    setState(() {
      if (!imagesPath.contains(path)) {
        newIndex++;
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
                    child: network[index] == 0
                        ? Center(
                            child: Image.file(
                              File(imagesPath[index]),
                              fit: BoxFit.cover,
                            ),
                          )
                        : Center(
                            child: Image.network(
                              imagesPath[index],
                              fit: BoxFit.cover,
                            ),
                          )),
                Positioned(
                    top: height * 0.008,
                    right: width * 0.05,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (network[index] == 1) {
                            imagesPath.removeAt(index);

                            network[index] = 0;
                          } else {
                            imagesPath.removeAt(index);
                            pickedImages.removeAt(newIndex);
                            newIndex--;
                          }
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

/*

 bool promo = numbertobool(isPromotion);
                          bool news = numbertobool(selectedNew);
                          if (_formKey.currentState!.validate()) {
                            List<String> downloadUrls = await productStorage
                                .uploadImages(pickedImages, Title);

                            List<String> colors = selectedColors
                                .map((element) => element.hashcode)
                                .toList();

                            Product product = Product(
                              promotion: Promotion,
                              id: widget.product.id,
                              stock: Stock,
                              images: downloadUrls,
                              colors: colors,
                              title: Title,
                              price: Price!.toDouble(),
                              description: Desctiption,
                              category: category,
                              newPrice: 0.1,
                              isNew: news,
                              isPromo: promo,
                            );
                          }
 */
