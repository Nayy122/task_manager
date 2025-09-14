import 'package:flutter/material.dart';
import 'package:task_manager/services/auth.dart';
import 'package:task_manager/shared/constants.dart';
import 'package:task_manager/shared/loading.dart';
class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({required this.toggleView});


  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final  AuthService _authService = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading=false;
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading?Loading(): Scaffold(
      backgroundColor: Color.fromRGBO(255, 228, 225, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 182, 193, 1.0),
        elevation: 0.0,
        title: Text('Sign In To Taskora '),
        actions: [
          TextButton.icon(icon: Icon(Icons.person), onPressed: () {widget.toggleView();  }, label: Text('Register'),)
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
                    validator: (val)=>val!.length < 6 ?'Enter a password of 6+ chatacters':null,
                    obscureText: true,
                    onChanged: (val) {
                      setState(() {
                        password=val;
                      });
                    }
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _authService.SignInWithEmailPassword(email, password);
                        if (result == null) {
                          setState(() {
                            error = 'Could not sign in kindly try again';
                            loading = false;
                          });
                        }
                      }
                      style:
                      ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.pinkAccent,);

                    }, child: Text('Sign In')),
                    SizedBox(height: 10.0),
                     Text(error,
                     style: TextStyle(color: Colors.pinkAccent,fontSize: 12.0),),
            ])
        ),
           ),
    );
  }
}
