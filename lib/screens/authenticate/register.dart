import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager/shared/constants.dart';
import '../../services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

import '../../shared/loading.dart';

class Register extends StatefulWidget {

final Function toggleView;
Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


  final  AuthService _authService = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading?Loading():Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.white60,
        elevation: 0.0,
        title: Text('Sign Up To Taskora '),
        actions: [
          TextButton.icon(icon: Icon(Icons.person), onPressed: () {widget.toggleView();  }, label: Text('Sign In'),)
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
        child:Form(
          key: _formkey,
            child: Column(
                children: [
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val)=>val!.isEmpty?'Enter an email':null,
                      onChanged: (val) {
                        setState(() {
                          email=val;
                        });
                      }
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'password'),
                      obscureText: true,
                      validator: (val)=>val!.length < 6 ?'Enter a password of 6+ chatacters':null,
                      onChanged: (val) {
                        setState(() {
                          password=val;
                        });
                      }
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      if(_formkey.currentState!.validate()){
                         setState(() {
                           loading = true;
                         });
                        dynamic result = await _authService.regWithEmailPassword(email, password);
                        if(result==null){
                          setState(() {
                            error='please provide valid email';
                            loading = false;
                          });
                        }

                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.pinkAccent,
                    ),
                    child:Text('Register'),
                  ),
                  SizedBox(height: 10.0),
                  Text(error,
                  style: TextStyle(color: Colors.pinkAccent,fontSize: 12.0),),
                ]),
        ),
      ),

    );
  }
}