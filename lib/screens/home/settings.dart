import 'package:flutter/material.dart';
import 'package:ninjabrew/models/user.dart';
import 'package:ninjabrew/services/database.dart';
import '../../shared/constant.dart';
import '../../services/database.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final key = GlobalKey<FormState>();
  final List<String> sugars = ["0", "1", "2", "3", "4"];
  String name;
  String _currentsugars = "0";
  int _currentstrength;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userdata,
        builder: (context, snapshot) {
          if(snapshot.hasData)
        {
           UserData userdata=snapshot.data;
         return Form(
              key: key,
              child: Column(children: [
                Padding(
                    padding:
                        EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                    child: Text(
                      "Update Your Brew Settings",
                      style: TextStyle(fontSize: 20.0),
                    )),
                Padding(
                    padding:
                        EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                    child: TextFormField(
                    initialValue: userdata.name,
                      decoration: txtinputdecoration.copyWith(hintText: "Name"),
                      
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Enter your Name";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) {
                        setState(() {
                          name= val;
                        });
                      },
                    )),
                //dropdown
                Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                  child: DropdownButtonFormField(
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                          value: sugar, child: Text("$sugar sugars"));
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _currentsugars = val;
                      });
                    },
                    value: userdata.sugars,
                  ),
                ),
                //slider
                Padding(
                    padding:
                        EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                    child: Slider(
                      value: (_currentstrength ?? userdata.strength).toDouble(),
                      min: 100,
                      max: 900,
                      activeColor: Colors.brown[_currentstrength ?? userdata.strength],
                      inactiveColor: Colors.brown[_currentstrength ?? userdata.strength],
                      divisions: 8,
                      onChanged: (val) {
                        setState(() {
                          _currentstrength = val.round();
                        });
                      },
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: RaisedButton(
                      color: Colors.pink[400],
                      child: Text("Update",
                          style:
                              TextStyle(color: Colors.white, fontSize: 15.0)),
                      onPressed: () async {
                        await DatabaseService(uid:user.uid).updateuserdata(
                          _currentsugars??userdata.sugars, 
                          name??userdata.name, 
                          _currentstrength??userdata.strength
                          );
                          Navigator.pop(context);
                      },

                    )),
              ]));
        }
        else{

        }
          
        });
  }
}
