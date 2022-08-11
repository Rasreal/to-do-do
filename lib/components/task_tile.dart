import 'package:flutter/material.dart';
import 'package:to_do_app/constants.dart';

class TaskTile extends StatefulWidget {
  final String TaskText;

  TaskTile({required this.TaskText});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        title: Text(widget.TaskText,
            style: eduvic.copyWith(
                color: Colors.white,
                decoration: check ? TextDecoration.lineThrough : null)),
        value: check,
        tileColor: Colors.white,
        activeColor: Colors.red,
        checkColor: Colors.white,
        selected: check,
        onChanged: (value) {
          setState(() {
            check = value!;
          });
        });
  }
}
