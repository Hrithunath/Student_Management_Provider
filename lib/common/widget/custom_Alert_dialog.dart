import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_provider/common/widget/custom_snackbar.dart';
import 'package:student_management_provider/provider/provider_controller.dart';

delete(BuildContext context, String name, int id) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Delete Confirmation"),
      content: const Text("Are You Sure You want to delete this student?"),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cencel")),
        ElevatedButton(
            onPressed: () async {
              Provider.of<StudentController>(context, listen: false)
                  .deleteStudent(id);
              showSnackBar("$name Deleted Succesfully", context);
              Navigator.pop(context);
            },
            child: const Text("Confirm"))
      ],
    ),
  );
}