import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/user.dart';
import 'package:task_manager/services/database.dart';
import 'package:task_manager/shared/constants.dart';
import 'package:task_manager/shared/loading.dart';


class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final formKey = GlobalKey<FormState>();
  final List<String>tasks = ['0','1','2','3','4'];

  //form values
  String _currentTasks='0';
   String _currentName='';
   int _currentHour=0;
  @override
  Widget build(BuildContext context) {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder<UserData>(
      stream: DatabaseService( uid: uid).userData,
      builder: (context, asyncSnapshot) {
        if(asyncSnapshot.hasData){
          UserData? userData = asyncSnapshot.data;
          return Form(
              key: formKey,
              child: Column(
                  children: [
                    Text('Update New Tasks.',
                      style: TextStyle(fontSize: 18.0),),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      initialValue: userData?.name,
                      decoration: textInputDecoration,
                      validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) =>
                          setState(() {
                            _currentName = val;
                          },
                          ),
                    ),
                    SizedBox(height: 20.0,),
                    //dropdown
                    DropdownButtonFormField(
                        decoration: textInputDecoration,
                        value: _currentTasks,
                        items: tasks.map((task) {
                          return DropdownMenuItem(
                            value: task,
                            child: Text('$task tasks'),
                          );
                        }).toList(),
                        onChanged: (val) => setState(() => _currentTasks = val!)),
                    //slider
                    Slider(
                      value: _currentHour.toDouble(),
                      activeColor: Colors.green[_currentHour??300],
                      inactiveColor: Colors.green[_currentHour??300],
                      min: 0,
                      max: 24,
                      divisions: 24,
                      label: '$_currentHour hrs',
                      onChanged: (val) =>
                          setState(() => _currentHour = val.round()),),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                        onPressed: () async {
                         if(formKey.currentState!.validate()){
                           await DatabaseService(uid: uid).updateUserData(_currentTasks?? userData!.tasks, _currentName ?? userData!.name, _currentHour ?? userData!.hours);
                           Navigator.pop(context);
                         }
                        }, child: Text('Update',
                      style: TextStyle(color: Colors.pink[300]),)
                    )
                  ]));
        }else{
           return Loading();
        }


      }
    );
  }
}
