import 'package:flutter/material.dart';
import 'package:ninjabrew/screens/home/home.dart';
import './authenticate/authenticate.dart';
import '../models/user.dart';
import 'package:provider/provider.dart';
class  Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);
    print(user);
    if(user==null)
    {
  return Authenticate();  
    }
    else
    {
   return Home(); 
    }
        //return either home or authenticate widget
    return Authenticate();
  }
}