import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/Widget/error_dialog.dart';
import 'package:final_year_project/admin/admin_home.dart';
import 'package:final_year_project/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key, this.data = null}) : super(key: key);
  final dynamic data;
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage>
    with AutomaticKeepAliveClientMixin<UploadPage> {
  bool get wantKeepAlive => true;
  File? file = null;
  String _productId = DateTime.now().millisecondsSinceEpoch.toString();
  bool _isUploading = false;
  final _form = GlobalKey<FormState>();
  late String category;
  late String title;
  late String description;
  late String price;
  late bool hasValue = false;
  late String image;
  late String productId;

  @override
  void initState() {
    if (widget.data == null) {
      return;
    }
    image = widget.data['imageUrl'].toString();
    category = widget.data['category'];
    title = widget.data['productName'];
    description = widget.data['description'];
    price = widget.data['price'].toString();
    hasValue = true;
    productId = widget.data['productId'];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffe46b10),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const AdminHomeScreen())),
        ),
        title: const Text('New Product'),
        actions: [
          IconButton(
              onPressed: () => _isUploading
                  ? null
                  : hasValue
                      ? updateItem(productId, image)
                      : uploadItem(),
              icon: const Icon(
                Icons.save,
                color: Colors.white,
              ))
        ],
      ),
      body: Form(
        key: _form,
        child: ListView(
          children: [
            _isUploading ? const LinearProgressIndicator() : const Text(''),
            file != null || hasValue
                ? SizedBox(
                    height: 230.0,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Center(
                      child: Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: hasValue
                                ? Image.network(image)
                                : Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: FileImage(file!),
                                            fit: BoxFit.cover)),
                                  ),
                          ),
                          TextButton(
                              onPressed: () {
                                takeImage(context);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'edit',
                                    style: Constants.regularPrimaryText,
                                  ),
                                  Icon(
                                    Icons.edit,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  )
                : Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        onPressed: () => takeImage(context),
                        child: Text('Add Image'))),
            const Padding(padding: EdgeInsets.only(top: 12)),
            ListTile(
              leading: const Text('Category'),
              title: SizedBox(
                width: 250,
                child: TextFormField(
                  initialValue: hasValue ? category : '',
                  onChanged: (value) {
                    category = value.toString();
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'category cant be empty';
                    }
                  },
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
              leading: Text('Title'),
              title: SizedBox(
                width: 250,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'title cant be empty';
                    }
                  },
                  initialValue: hasValue ? title : '',
                  onChanged: (value) {
                    title = value.toString();
                  },
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
              leading: const Text('Description'),
              title: SizedBox(
                width: 250,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Description cant be empty';
                    }
                  },
                  onChanged: (value) {
                    description = value.toString();
                  },
                  initialValue: hasValue ? description : '',
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
              leading: const Text('Price'),
              title: SizedBox(
                width: 250,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'price cant be empty';
                    }
                  },
                  onChanged: (value) {
                    price = value.toString();
                  },
                  keyboardType: TextInputType.number,
                  initialValue: hasValue ? price.toString() : '',
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

  // To upload item to FireStore
  uploadItem() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    } else if (file == null) {
      showDialog(
          context: context,
          builder: (c) => const ErrorAlertDialog(
                message: 'please,add product images.',
              ));
      return;
    } else {
      setState(() {
        _isUploading = true;
      });
      String imageDownloadUrl = await upLoadImage(file);
      saveItemInfo(imageDownloadUrl);
    }
  }

  // To upload image into Storage
  Future<String> upLoadImage(fileImage) async {
    showDialog(context: context, builder: (ctx) => CircularProgressIndicator());
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
      'category': category,
      'description': description,
      'productName': title,
      'price': double.parse(price),
      'status': 'available',
      'imageUrl': imageUrl,
      'productId': _productId,
    }).then((value) {
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: 'Item added successfully');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => AdminHomeScreen()));
    });
  }

  updateItem(productId, image) async {
    showDialog(context: context, builder: (ctx) => CircularProgressIndicator());
    final itemRef = await FirebaseFirestore.instance.collection('products');
    itemRef.doc(productId).set({
      'category': category,
      'description': description,
      'productName': title,
      'price': double.parse(price),
      'status': 'available',
      'imageUrl': image,
      'productId': productId,
    }).then((value) {
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: 'Edited successfully');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => AdminHomeScreen()));
    });
  }
}
