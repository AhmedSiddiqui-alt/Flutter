import 'package:flutter/material.dart';
import '../../services/auth.dart';
import '../../shared/constant.dart';

class Register extends StatefulWidget {
  final Function toggle;
  Register({this.toggle});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final AuthService _auth=AuthService();
  final _formkey = GlobalKey<FormState>();
  String error="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text("Sign up to Brew Crew"),
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () {
                widget.toggle();
              },
              icon: Icon(Icons.person),
              label: Text("Sign in"),
            )
          ],
        ),
        body: Container(
            child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding:
                            EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                        child: TextFormField(
                          decoration:txtinputdecoration.copyWith(hintText:"Email") ,
                          controller: email,
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Enter your email address";
                            } else {
                              return null;
                            }
                          },
                        )),
                    Padding(
                        padding:
                            EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                        child: TextFormField(
                          decoration:txtinputdecoration.copyWith(hintText:"Password") ,
                          obscureText: true,
                          controller: password,
                          validator: (val) {
                            if (val.length < 6) {
                              return "Your Passowrd should be 6+ char long";
                            } else {
                              return null;
                            }
                          },
                        )),
                    Padding(
                        padding:
                            EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                        child: RaisedButton(
                          color: Colors.pink[400],
                          child: Text("Register",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15.0)),
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              dynamic result=await _auth.RegisterWithEmailAndpassword(email.text, password.text);
                              if(result==null)
                              {
                              setState(() {
                                error="Please supply a valid email and password";
                              });
                              }
                            }
                          },
                        )
                        ),
                        Padding(padding:EdgeInsets.only(top:20.0),
                          child:
                        Text("$error",
                        style:TextStyle(
                          fontSize: 20.0,
                          color:Colors.red
                        )
                        )
                        )
                  ],
                ))));
  }
}
