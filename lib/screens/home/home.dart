import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/screens/home/settings_form.dart';
import 'package:task_manager/services/auth.dart';
import 'package:task_manager/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/screens/home/task_list.dart';

import '../../models/tasks.dart';
class Home extends StatelessWidget {

 final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding:EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }
    return StreamProvider<List<Tasks>?>.value(value: DatabaseService(uid: '').tasks,
      initialData: null,
      child:Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        title: Text('Taskora'),
        backgroundColor: Colors.white60,
        elevation: 0.0,
        actions: [
          TextButton.icon(icon: Icon(Icons.person),
            onPressed: () async {
               await _auth.signOut();
            }, label: Text('Logout'),
          ),
          TextButton.icon(icon: Icon(Icons.settings),
              onPressed:() => _showSettingsPanel(), label: Text('Settings'))
        ],
      ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/task_bgnd.jpg'),
              fit: BoxFit.cover,
          ),
          ),
            child: TaskList()
        ),
      ));
  }
}
