import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'tasks.dart';
import 'package:to_do_app/database/firebase.dart';
import 'package:to_do_app/screens/task_screen.dart';

class TaskNotify extends ChangeNotifier{
  List<Task> task = [
  ];

  void addTaskNotify(String taskName){
    //task.add(Task(task_name: taskName));
    Firebase_all().addTaskDB(taskName);

    //notifyListeners();
  }
  void dataSize(var data){
    data_size = data.size;
    notifyListeners();
  }
  int dataSIZE(){
    return data_size;
  }
}