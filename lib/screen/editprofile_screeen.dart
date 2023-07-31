import 'dart:typed_data';

import 'package:bca_quiz/screen/profile_screen.dart';
import 'package:bca_quiz/utils/colors.dart';
import 'package:bca_quiz/utils/utils.dart';
import 'package:bca_quiz/widgets/text_field_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: mobileBackgroundColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: ListView(
          children: [
            Flexible(
              flex: 1,
              child: Container(),
            ),
            const SizedBox(
              height: 24,
            ),
            const Align(
                child: Text(
              "Edit Profile",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )),
            const SizedBox(
              height: 24,
            ),
            Center(child: _buildCircularAvatar()),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              textEditingController: _usernameController,
              hintText: "Enter your Username",
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              textEditingController: _emailController,
              hintText: "Enter your E-mail",
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              textEditingController: _bioController,
              hintText: "Enter your Bio",
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 24,
            ),
            TextButton(
              onPressed: () async {
                final String name = _usernameController.text;
                final String email = _emailController.text;
                final String bio = _bioController.text;

                await _users
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .update({"username": name, "email": email, "bio": bio});
                _usernameController.text = '';
                _emailController.text = '';
                _bioController.text = '';

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                            uid: FirebaseAuth.instance.currentUser!.uid)));
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
                backgroundColor: mobileBottom,
              ),
              child: const Text("save"),
            ),
            const SizedBox(
              height: 24,
            ),
            Flexible(
              flex: 2,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  Stack _buildCircularAvatar() {
    return Stack(
      children: [
        _image != null
            ? CircleAvatar(
                radius: 64,
                backgroundImage: MemoryImage(_image!),
              )
            : const CircleAvatar(
                radius: 64,
                backgroundImage: CachedNetworkImageProvider(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzdtrH-5bQQnZmu7ZTCIKUqGneaGkwP04KseoDfFFucE4_vF345hVrGaQeS-0vYmFurm8&usqp=CAU"),
              ),
        Positioned(
          bottom: -10,
          left: 80,
          child: IconButton(
            onPressed: selectImage,
            icon: const Icon(Icons.add_a_photo),
          ),
        ),
      ],
    );
  }
}
