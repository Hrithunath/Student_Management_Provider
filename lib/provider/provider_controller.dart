import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_management_provider/model/db_model.dart';

class StudentController extends ChangeNotifier {
  List<Student> students = [];
  List<Student> results = [];

  StudentController() {
    getStudents();
  }
  getStudents() async {
    final box = await Hive.openBox<Student>('students');
    students = box.values.toList();
    results = box.values.toList();
    notifyListeners();
  }

  addStudent(Student data) async {
    final box = await Hive.openBox<Student>('students');
    await box.add(data);
    students = box.values.toList();
    results = students;
    notifyListeners();
  }

  updateStudent(Student data, int id) async {
    final box = await Hive.openBox<Student>('students');
    await box.put(id, data);
    students = box.values.toList();
    results = students;
    notifyListeners();
  }

  void deleteStudent(int id) async {
    final box = await Hive.openBox<Student>('students');
    await box.delete(id);
    students = box.values.toList();
    results = students;
    notifyListeners();
  }

  Student? getStudentById(int id) {
    return students.firstWhere((student) => student.key == id);
  }

  search(String query) {
    if (query.isEmpty) {
      results = students;
    } else {
      results = students
          .where((element) =>
              element.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
