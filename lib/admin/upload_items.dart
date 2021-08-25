import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/screens/login_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'admin_shift_orders.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage>
    with AutomaticKeepAliveClientMixin<UploadPage> {
  bool get wantKeepAlive => true;
  File? file = null;
  final _descriptionTextEditingController = TextEditingController();
  final _priceTextEditingController = TextEditingController();
  final _titleTextEditingController = TextEditingController();
  final _categoryTextEditingController = TextEditingController();
  String _productId = DateTime.now().millisecondsSinceEpoch.toString();
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return file == null
        ? displayAdminHomeScreen()
        : displayAdminUploadFormScreen();
  }

  displayAdminHomeScreen() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffe46b10),
        leading: IconButton(
          icon: const Icon(
            Icons.border_color,
            color: Colors.white,
          ),
          onPressed: () {
            Route route = MaterialPageRoute(builder: (c) => AdminShiftOrders());
            Navigator.push(context, route);
          },
        ),
        actions: [
          TextButton(
            child: const Text(
              'logout',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Route route =
                  MaterialPageRoute(builder: (c) => const LoginScreen());
              Navigator.push(context, route);
            },
          ),
        ],
      ),
      body: adminHomeBody(),
    );
  }

  adminHomeBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.shop_two,
            size: 200,
            color: Color(0xffe46b10),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
              child: const Text(
                'Add new item',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xffe46b10))),
              onPressed: () => takeImage(context),
            ),
          )
        ],
      ),
    );
  }

  takeImage(context) {
    return showDialog(
        context: context,
        builder: (c) {
          return SimpleDialog(
            title: const Text(
              'Select Image',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Color(0xffe46b10)),
            ),
            children: [
              SimpleDialogOption(
                child: const Text('Camera'),
                onPressed: _captureImage,
              ),
              SimpleDialogOption(
                child: const Text('Gallery'),
                onPressed: _pickFromGallery,
              ),
              SimpleDialogOption(
                child: IconButton(
                  icon: const Icon(
                    Icons.cancel,
                    size: 40,
                    color: Colors.orange,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          );
        });
  }

  _captureImage() async {
    Navigator.pop(context);
    final _picker = ImagePicker();
    XFile? imageFile = await _picker.pickImage(
        source: ImageSource.camera, maxHeight: 680.0, maxWidth: 970.0);
    setState(() {
      file = File(imageFile!.path);
    });
  }

  _pickFromGallery() async {
    Navigator.pop(context);
    final _picker = ImagePicker();
    XFile? imageFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(imageFile!.path);
    });
  }

  displayAdminUploadFormScreen() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffe46b10),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: clearFormInfo,
        ),
        title: const Text('New Product'),
        actions: [
          IconButton(
              onPressed: _isUploading ? null : () => uploadItem(),
              icon: const Icon(
                Icons.save,
                color: Colors.white,
              ))
        ],
      ),
      body: ListView(
        children: [
          _isUploading ? const CircularProgressIndicator() : const Text(''),
          SizedBox(
            height: 230.0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(file!), fit: BoxFit.cover)),
                ),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 12)),
          ListTile(
            leading: const Icon(
              Icons.perm_device_information,
              color: Color(0xffe46b10),
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: _categoryTextEditingController,
                decoration: const InputDecoration(
                    hintText: 'Category',
                    hintStyle: TextStyle(color: Colors.grey),
                    focusColor: Color(0xffe46b10),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffe46b10)),
                    )),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.perm_device_information,
              color: Color(0xffe46b10),
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: _titleTextEditingController,
                decoration: const InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.grey),
                    focusColor: Color(0xffe46b10),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffe46b10)),
                    )),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.perm_device_information,
              color: Color(0xffe46b10),
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: _descriptionTextEditingController,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  hintStyle: TextStyle(color: Colors.grey),
                  focusColor: Color(0xffe46b10),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffe46b10)),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.perm_device_information,
              color: Color(0xffe46b10),
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _priceTextEditingController,
                decoration: const InputDecoration(
                  hintText: 'Price',
                  hintStyle: TextStyle(color: Colors.grey),
                  focusColor: Color(0xffe46b10),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffe46b10)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  clearFormInfo() {
    setState(() {
      file = null;
      _descriptionTextEditingController.clear();
      _categoryTextEditingController.clear();
      _priceTextEditingController.clear();
      _categoryTextEditingController.clear();
    });
  }

  // To upload item to FireStore
  uploadItem() async {
    setState(() {
      _isUploading = true;
    });
    String imageDownloadUrl = await upLoadImage(file);
    saveItemInfo(imageDownloadUrl);
  }

  // To upload image into Storage
  Future<String> upLoadImage(fileImage) async {
    final storageRef = FirebaseStorage.instance.ref().child('Items Images');
    final uploadTask =
        storageRef.child('product_$_productId.jpg').putFile(fileImage);
    String downloadUrl = await uploadTask.then((res) {
      final url = res.ref.getDownloadURL();
      return url;
    });
    return downloadUrl;
  }

// Finally to store imageurl with item data to firestore
  saveItemInfo(String imageUrl) {
    final itemRef = FirebaseFirestore.instance.collection('products');
    itemRef.doc(_productId).set({
      'category': _categoryTextEditingController.text.trim(),
      'description': _descriptionTextEditingController.text.trim(),
      'productName': _titleTextEditingController.text.trim(),
      'price': double.parse(_priceTextEditingController.text.trim()),
      'productId': DateTime.now(),
      'status': 'available',
      'thumbnailUrl': imageUrl,
      'id': _productId,
    });
    setState(() {
      file = null;
      _isUploading = false;
      _productId = DateTime.now().millisecondsSinceEpoch.toString();
      _categoryTextEditingController.clear();
      _descriptionTextEditingController.clear();
      _titleTextEditingController.clear();
      _priceTextEditingController.clear();
    });
  }
}
