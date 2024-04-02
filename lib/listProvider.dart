
import 'package:flutter/material.dart';

class TaskListProvider extends ChangeNotifier{

  List<String>addTaskList =[];


  void addTask(String task){
    addTaskList.add(task);
    notifyListeners();
  }

  void removeTask(int index){
    addTaskList.removeAt(index);
    notifyListeners();
  }

}