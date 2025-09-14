import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import  'package:task_manager/screens/home/task_tile.dart';
import 'package:task_manager/models/tasks.dart';
 
class TaskList extends StatefulWidget {
  const TaskList({super.key});



  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {

    final task = Provider.of<List<Tasks>>(context) ?? [];

    return ListView.builder(
        itemCount: task.length,
       itemBuilder: (context,index) {
          return TaskTile(task:task[index]); },);

  }}


