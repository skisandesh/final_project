import 'dart:io';
import 'package:final_year_project/Widget/custom_elevatedbutton.dart';
import 'package:final_year_project/Widget/custom_top_bar.dart';
import 'package:final_year_project/Widget/error_dialog.dart';
import 'package:final_year_project/Widget/loading_dialog.dart';
import 'package:final_year_project/adaptive_and_responsive/adaptive.dart';
import 'package:final_year_project/constants.dart';
import 'package:final_year_project/firebase_services/userinfo.dart';
import 'package:final_year_project/screens/profile_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final usernameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final sexController = TextEditingController();
  final stateController = TextEditingController();
  final vdcMunController = TextEditingController();
  final cityController = TextEditingController();
  final locationController = TextEditingController();

  bool _hasImage = false;
  late File _imageFile;

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;

    Future<void> _selectAndPickImage() async {
      final _picker = ImagePicker();
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _imageFile = File(pickedImage!.path);
        _hasImage = true;
      });
    }

    displayDialog(String msg) {
      showDialog(
          context: context,
          builder: (ctx) {
            return ErrorAlertDialog(message: msg);
          });
    }

    uploadToStorage() async {
      showDialog(
          context: context,
          builder: (ctx) => const LoadingAlertDialog(
                message: 'Registering ,please wait',
              ));
      String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child(imageFileName);
      UploadTask uploadTask = storageReference.putFile(_imageFile);
      uploadTask.then((res) {
        res.ref.getDownloadURL().then((value) {
          UserService()
              .saveUserInfo(
                  usernameController.text.trim(),
                  value.toString(),
                  phoneNumberController.text.trim(),
                  stateController.text.trim(),
                  vdcMunController.text.trim(),
                  cityController.text.trim(),
                  locationController.text.trim(),
                  sexController.text.trim())
              .then((value) {
            Navigator.pop(context);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const ProfileScreen()));
          });
        });
      });
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (!Adaptive.isMobile(context)) const TopBar(),
              const Align(alignment: Alignment.topLeft, child: BackButton()),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Edit Profile',
                style: Constants.headingPrimaryText,
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: _selectAndPickImage,
                  child: CircleAvatar(
                    radius: Adaptive.isMobile(context)
                        ? _screenWidth * 0.15
                        : _screenWidth * 0.05,
                    backgroundColor: Colors.grey,
                    backgroundImage: _hasImage ? FileImage(_imageFile) : null,
                    child: _hasImage
                        ? null
                        : Icon(
                            Icons.add_photo_alternate,
                            size: Adaptive.isMobile(context)
                                ? _screenWidth * 0.15
                                : _screenWidth * 0.05,
                            color: const Color(0xffe46b10),
                          ),
                  )),
              editCard(context),
              const SizedBox(
                height: 30,
              ),
              CustomElevatedButton(
                  onPressed: () {
                    if (!_hasImage) {
                      return displayDialog('Please Select Image');
                    } else {
                      if (usernameController.text.isNotEmpty &&
                          phoneNumberController.text.isNotEmpty &&
                          stateController.text.isNotEmpty &&
                          vdcMunController.text.isNotEmpty &&
                          cityController.text.isNotEmpty &&
                          sexController.text.isNotEmpty &&
                          locationController.text.isNotEmpty) {
                        uploadToStorage();
                      } else {
                        return displayDialog('Please fill complete form');
                      }
                    }
                  },
                  buttonText: 'Save',
                  textStyle: Constants.headingWhiteText,
                  color: Theme.of(context).primaryColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget editCard(context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.grey[200],
        width: Adaptive.isMobile(context)
            ? MediaQuery.of(context).size.width * 0.8
            : MediaQuery.of(context).size.width * 0.5,
        child: Column(
          children: [
            rowTextField(field: 'User Name', controller: usernameController),
            rowTextField(
                field: 'Phone Number',
                controller: phoneNumberController,
                isNum: true),
            rowTextField(field: 'Sex', controller: sexController),
            rowTextField(field: 'State', controller: stateController),
            rowTextField(
                field: 'VDC/Municipality', controller: vdcMunController),
            rowTextField(field: 'City', controller: cityController),
            rowTextField(field: 'Location', controller: locationController),
          ],
        ),
      ),
    );
  }

  Widget rowTextField({field, controller, isNum = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(flex: 1, child: Text(field)),
        Expanded(
            flex: 2,
            child: TextFormField(
              keyboardType: isNum ? TextInputType.number : TextInputType.text,
              controller: controller,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                focusColor: Theme.of(context).primaryColor,
              ),
            )),
      ],
    );
  }
}
