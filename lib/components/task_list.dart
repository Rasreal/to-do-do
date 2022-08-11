import 'package:flutter/material.dart';
import 'package:to_do_app/constants.dart';
import 'package:to_do_app/module/tasks.dart';
import 'task_tile.dart';
import 'package:to_do_app/module/tasks_notifier.dart';
import 'package:provider/provider.dart';

class TaskList extends StatefulWidget {

  final int item_count;
  final dynamic doctask;
  TaskList({required this.item_count, required this.doctask});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskNotify>(
      builder: (context, taskNotify, child){
        return ListView.builder(
          itemBuilder: (context, index) {
            return TaskTile(TaskText: widget.doctask.docs[index]['Task']);
          },
          itemCount: widget.item_count,
        );
      },

    );
  }
}
