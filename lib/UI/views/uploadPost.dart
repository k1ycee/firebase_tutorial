import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tuts/logic/firstore.dart';
import 'package:tuts/utils/colors.dart';

class UploadPost extends StatefulWidget {
  const UploadPost({Key? key}) : super(key: key);

  @override
  _UploadPostState createState() => _UploadPostState();
}

class _UploadPostState extends State<UploadPost> {
  bool complete = false;
  Database database = Database();
  TextEditingController postController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? pickedImage;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 40,
                        width: 40,
                        child: Center(
                          child: ImageIcon(
                            AssetImage("images/undo.png"),
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: lightBlue,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await database.createPost(
                              postMessage: postController.text,
                              pickedImage: pickedImage);
                          Navigator.pop(context);
                        }
                      },
                      child: SvgPicture.asset(
                        "images/send.svg",
                        color: complete ? lightBlue : lightGrey,
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 150,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "You need to write something";
                            }
                          },
                          maxLines: 1000,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                complete = true;
                              });
                            }
                          },
                          controller: postController,
                          decoration: InputDecoration(
                            hintText: "Write Something",
                            hintStyle: TextStyle(color: lightGrey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {
                        // print("Pick an Image");
                        final image = await selectImage();
                        setState(() {
                          pickedImage = image;
                        });
                      },
                      child: SvgPicture.asset("images/camera.svg",
                          height: 30, width: 30),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: pickedImage == null
                      ? Center(
                          child: Text(
                            'Add an Image',
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                        )
                      // If we have a selected image we want to show it
                      : Image.file(pickedImage!),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<File> selectImage() async {
    // Initialize Image picker package
    final ImagePicker selectImage = ImagePicker();
    // selecting an Image
    final XFile? selectedImage =
        await selectImage.pickImage(source: ImageSource.gallery);
    final path = File(selectedImage!.path);
    return path;
  }
}
