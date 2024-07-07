import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/common/widget/custom_Alert_dialog.dart';
import 'package:student_management_provider/screens/add_students.dart';
import 'package:student_management_provider/screens/edit_students.dart';
import 'package:student_management_provider/screens/search.dart';
import 'package:student_management_provider/screens/view.dart';

import '../provider/provider_controller.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          const SizedBox(width: 10),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchStudent()));
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Consumer<StudentController>(
        builder: (context, studentController, child) {
          return studentController.students.isEmpty
              ? const Center(
                  child: Text(
                    "No data, add One!",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 22),
                  ),
                )
              : ListView.builder(
                  itemCount: studentController.students.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.grey[200],
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Profile(
                                    studentId:
                                        studentController.students[index].key)),
                          );
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(
                                File(studentController.students[index].image)),
                          ),
                          title: Text(
                            studentController.students[index].name,
                          ),
                          subtitle:
                              Text(studentController.students[index].classs),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      (MaterialPageRoute(
                                          builder: (context) => EditStudents(
                                              student: studentController
                                                  .students[index]))));
                                },
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                    delete(
                                  context,
                                  studentController.students[index].name,
                                  studentController.students[index].key);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red[600],
                            )
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddStudents()),
          );
        },
        backgroundColor: Colors.yellow,
        child: const Icon(Icons.add),
      ),
    );
  }
}
