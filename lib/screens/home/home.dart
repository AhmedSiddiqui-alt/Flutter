import 'package:flutter/material.dart';
import 'package:ninjabrew/models/brew.dart';
import 'package:ninjabrew/screens/home/settings.dart';
import 'package:ninjabrew/services/auth.dart';
import '../../services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'brew_list.dart'; 
class Home extends StatelessWidget {
  @override
  final AuthService _auth=AuthService();
  Widget build(BuildContext context) {
      void showsettingpanel()
  {
    showModalBottomSheet(context: context, builder: (context)
    {
   return Container(
     child:
     Padding(padding: EdgeInsets.only(left: 10.0,right:10.0),

       child:Settings()
     )
   );
    });
  }
    return
    StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child:
     Scaffold(
      backgroundColor: Colors.brown[40],
      appBar:AppBar(title:Text('Brew Crew'),
      backgroundColor: Colors.brown[400],
      elevation: 0.0,
      actions: <Widget>[
        FlatButton.icon(
          icon: Icon(Icons.person),
          label:Text("logout"),
          onPressed: (){
         _auth.signout();
          },
         ),
         FlatButton.icon(
         icon:Icon(Icons.settings),
         label: Text("settings"),
         onPressed: ()
         {
         showsettingpanel();
         },
         )
         ],
      ),
      body:BrewList()
    )
    );
  
  }

}