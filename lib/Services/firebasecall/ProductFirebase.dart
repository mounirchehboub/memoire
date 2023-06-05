import '../../models/ProductModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductFirebase {
  CollectionReference products =
      FirebaseFirestore.instance.collection("Products");

  //Function to get Products from Firebase
  Future<List<QueryDocumentSnapshot<Product>>> getProductsData() async {
    final ref = products.withConverter(
      fromFirestore: Product.fromFirestore,
      toFirestore: (Product product, _) => product.toFirestore(),
    );
    final docSnap = await ref.get();
    final product = docSnap.docs; // Convert to City object
    if (product != null) {
      return product;
    } else {
      print("No such document.");
    }
    return [];
  }

  // Function to get products by category tap

  Future<List<QueryDocumentSnapshot<Product>>> getProdbyCat(String category) {
    final ref = products.withConverter(
      fromFirestore: Product.fromFirestore,
      toFirestore: (Product product, _) => product.toFirestore(),
    );
    final docSnap = ref.where('category', isEqualTo: category).get();
    final product = docSnap.then((product) {
      return product.docs;
    });
    return product;
  }

  // Function to get Products by Title
  Future<List<QueryDocumentSnapshot<Product>>> getProdbyTitle(String title) {
    final ref = products.withConverter(
      fromFirestore: Product.fromFirestore,
      toFirestore: (Product product, _) => product.toFirestore(),
    );
    final docSnap = ref
        .where('title', isGreaterThanOrEqualTo: title)
        .where('title', isLessThan: title + 'z')
        .get();
    final product = docSnap.then((product) {
      return product.docs;
    });
    return product;
  }

  //Function to get 10 first Product Document
  Future<List<QueryDocumentSnapshot<Product>>> getTenProducts() async {
    final ref = products.withConverter(
      fromFirestore: Product.fromFirestore,
      toFirestore: (Product product, _) => product.toFirestore(),
    );
    final docSnap = await ref.limit(10).get();
    final product = docSnap.docs; // Convert to City object
    if (product != null) {
      return product;
    } else {
      print("No such document.");
    }
    return [];
  }

  //Admin Function
  //Function to add a new Product to Firebase
  Future<void> addProduct(Product product) async {
    final docref = products
        .withConverter(
          fromFirestore: Product.fromFirestore,
          toFirestore: (Product product, _) => product.toFirestore(),
        )
        .doc();
    await docref.set(product).then((value) {
      updateProductId(docref.id);
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  //Funciton to Update product id with docref.id
  Future<void> updateProductId(String productId) async {
    await products.doc(productId).update({'productId': productId}).then(
        (value) => print('Updated Succsssessfulyy'));
  }

  //Function to Delete a Product
  Future<void> DeleteProduct(String uid) async {
    await products.doc(uid).delete().then((document) {
      print("document Deleted Successfully");
    }, onError: (error) {
      print("Error in Deleting Product");
    });
  }

// Function to update the stock ---Working Tested---
  Future<void> updateStock(String uid, int newStock) async {
    await products
        .doc(uid)
        .update({"stock": newStock})
        .then((value) => print('Updated Successfuly'))
        .onError((error, stackTrace) => print(error.toString()));
  }

//Function to update Promotion

  Future<void> updatePromotion(
      String uid, bool isPromotion, int promoNumber) async {
    await products
        .doc(uid)
        .update({"isPromo": isPromotion, "promotion": promoNumber})
        .then((value) => print('Updated Successfuly'))
        .onError((error, stackTrace) => print(error.toString()));
  }

//Function to Update GeneralFields

  Future<void> updateGeneralFields(
      Map<String, dynamic> data, String uid) async {
    await products
        .doc(uid)
        .update(data)
        .then((value) => print('UpdatedSuccessfully'))
        .onError((error, stackTrace) => print(error.toString()));
  }
}
