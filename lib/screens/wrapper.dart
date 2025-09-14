import 'package:provider/provider.dart';
import 'package:task_manager/screens/authenticate/sign_in.dart';
import 'package:task_manager/screens/home/home.dart';
import 'package:flutter/material.dart';

import '../services/auth.dart';
import 'authenticate/authenticate.dart';
class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<User?>(context);
    if (users == null) {
      return Authenticate(); // or whatever your login screen is
    } else {
      return Home();
    }
  }
}
