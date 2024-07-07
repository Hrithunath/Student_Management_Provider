import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/provider/provider_controller.dart';


class Profile extends StatelessWidget {
    final int studentId;


  const Profile({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
     final student =
        Provider.of<StudentController>(context).getStudentById(studentId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                height: 150,
                width: 150,
                color: Colors.grey.withOpacity(0.5),
                child: student!.image.isNotEmpty && File(student.image).existsSync()
                  ? Image.file(
                      File(student.image),
                      fit: BoxFit.cover,
                    )
                  : const Icon(
                      Icons.person,
                      size: 100,
                      color: Colors.white,
                    ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              student.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              student.classs,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              student.admissionNumber,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              student.address,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
