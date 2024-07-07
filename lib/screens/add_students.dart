import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/common/widget/custom_snackbar.dart';
import 'package:student_management_provider/model/db_model.dart';
import 'package:student_management_provider/provider/provider_controller.dart';

class AddStudents extends StatefulWidget {
  const AddStudents({super.key});

  @override
  State<AddStudents> createState() => _AddStudentsState();
}

class _AddStudentsState extends State<AddStudents> {
  final formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final classsController = TextEditingController();
  final admissionController = TextEditingController();
  final addressController = TextEditingController();
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              const SizedBox(height: 15),
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: selectedImage != null
                        ? FileImage(selectedImage!)
                        : null,
                    child: selectedImage == null
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                  Positioned(
                    left: 60,
                    bottom: -10,
                    child: IconButton(
                      onPressed: imagePickGallery,
                      icon: const Icon(Icons.add_a_photo_outlined),
                      iconSize: 25,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "Enter your full name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name is required";
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: classsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Class",
                  hintText: "Enter your class",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Class is required";
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: admissionController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Admission Number",
                  hintText: "Enter your Admission Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Admission Number is required";
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: addressController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: "Address",
                  hintText: "Enter your full Address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Address is required";
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      nameController.clear();
                      classsController.clear();
                      admissionController.clear();
                      addressController.clear();
                      setState(() {
                        selectedImage = null;
                      });
                    },
                    child: const Text(
                      'Clear',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: saveButton,
                    child: const Text(
                      'Save',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> imagePickGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  saveButton() async {
    if (formkey.currentState!.validate()) {
      final student = Student();
      student.name = nameController.text;
      student.classs = classsController.text;
      student.admissionNumber = admissionController.text;
      student.address = addressController.text;
      student.image = selectedImage!.path.toString();
      await Provider.of<StudentController>(context, listen: false)
          .addStudent(student);
      showSnackBar("${student.name} Added Succesfully", context);
      Navigator.pop(context);
    }
  }
}
