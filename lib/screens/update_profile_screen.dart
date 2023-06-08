import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_news_/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_/Provider/user_provider.dart';
import 'package:flutter_news_/common/app_color.dart';
import 'package:flutter_news_/common/app_textstyle.dart';
import 'package:flutter_news_/components/custom_button.dart';
import 'package:provider/provider.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const String routeName = '/update-profile-screen';

  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  PlatformFile? pickFile;
  UploadTask? uploadTask;

  final _updateProfileKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  // Future uploadFile() async {
  //   final path = 'ProfilePicture/${pickFile!.name}';
  //   final file = File(pickFile!.path!);

  //   final ref = FirebaseStorage.instance.ref().child(path);
  //   uploadTask = ref.putFile(file);

  //   final snapshot = await uploadTask!.whenComplete(() {});

  //   final urlDownload = await snapshot.ref.getDownloadURL();
  //   print('Download Link: $urlDownload');
  // }

  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<AppUser>(context);

    void showPermissionSnackbar(BuildContext context) {
      final snackBar = SnackBar(
        content: Text('Storage permission denied. Please enable it manually.'),
        action: SnackBarAction(
          label: 'Open Settings',
          onPressed: () {
            openAppSettings();
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    void selectImage() async {
      Uint8List img = await pickImage(ImageSource.gallery);

      setState(() {
        _image = img;
      });

      appUser.uploadImagetoStorage(appUser.user?.displayName! as String, img);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile Update',
          style: AppTextStyle.abezee(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              appUser.updateProfile(
                displayName: nameController.text,
                email: emailController.text,
                phoneNumber: phoneNumberController.text,
              );
            },
            child: Text(
              'Save',
              style: AppTextStyle.abezee(
                color: AppColor.yellowGold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {},
                child: Center(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          selectImage();
                        },
                        child: Stack(
                          children: [
                            _image != null
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundImage: MemoryImage(_image!),
                                  )
                                : CircleAvatar(
                                    radius: 50,
                                    child: appUser.user?.photoURL as String ==
                                            null
                                        ? Image.asset(
                                            'assets/images/user.png',
                                            fit: BoxFit.contain,
                                          )
                                        : ClipOval(
                                            child: Image.network(
                                              appUser.user?.photoURL as String,
                                              fit: BoxFit.cover,
                                              width: 120,
                                              height: 120,
                                            ),
                                          ),
                                  ),
                            Positioned(
                              top: 60,
                              left: 65,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(17),
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (pickFile != null) Text(pickFile!.name),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _updateProfileKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fullname',
                      style: AppTextStyle.abezee(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(
                            Icons.edit,
                            color: AppColor.paleGrey,
                          ),
                          hintText: appUser.user?.displayName ??
                              'No information available',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Email',
                      style: AppTextStyle.abezee(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(
                            Icons.edit,
                            color: AppColor.paleGrey,
                          ),
                          hintText: appUser.user?.email! ??
                              'No information available',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Phone Number',
                      style: AppTextStyle.abezee(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(
                            Icons.edit,
                            color: AppColor.paleGrey,
                          ),
                          hintText: appUser.user?.phoneNumber ??
                              'No information available',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              CustomButton(
                textButton: 'Logout',
                onTap: () {
                  appUser.logOut(context);
                },
                backgroundTextColor: Colors.deepPurple,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
