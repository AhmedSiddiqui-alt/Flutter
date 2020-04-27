import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ninjabrew/screens/home/brew_tile.dart';
import 'package:provider/provider.dart';
import '../../models/brew.dart';
class  BrewList extends StatefulWidget {
  @override
  
  _BrewListState createState() => _BrewListState();
}


class _BrewListState extends State<BrewList> {
  @override
   Brew brew;
  Widget build(BuildContext context) {
  Brew brew;
    final brews=Provider.of<List<Brew>>(context)??[];
    //print brews document
     brews.forEach((b)
     {
       print(b.name);
       print(b.strength);
       print(b.sugars);
       
     });
     return ListView.builder(
       itemCount: brews.length,
       itemBuilder: (context,index)
       {
        return BrewTile(brew:brews[index]); 
       });

  }
}