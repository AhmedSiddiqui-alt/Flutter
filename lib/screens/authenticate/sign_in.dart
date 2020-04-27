import 'package:flutter/material.dart';
import 'package:ninjabrew/services/auth.dart';
import '../../shared/constant.dart';
class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn({this.toggle});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String error="";
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text("Sign in to Brew Crew"),
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () {
                widget.toggle();
              },
              icon: Icon(Icons.person),
              label: Text("Register"),
            )
          ],
        ),
        /*Container(
            padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
            child: RaisedButton(
                child: Text("Sign in anon"), 
                onPressed: () async 
                {
                dynamic result=await _auth.signinAnom();
                if(result==null)
                {
                  print("error signed in");
                }
                else
                {
                  print("signed in");
                  print(result.uid);
                }
                }
                )
                )*/
        body: Container(
            child: Form(
               key: _formkey,
                child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
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
                padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                child: TextFormField(
                  decoration:txtinputdecoration.copyWith(hintText:"Password") ,
                  validator: (val) {
                            if (val.length < 6) {
                              return "Your Passowrd should be 6+ char long";
                            } else {
                              return null;
                            }
                          },
                  obscureText: true,
                  controller: password,
                )),
            Padding(
                padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                child: RaisedButton(
                  color: Colors.pink[400],
                  child: Text("Sign in",
                      style: TextStyle(color: Colors.white, fontSize: 15.0)),
                  onPressed: () async {
                    dynamic result=await _auth.SigninWithEmailAndpassword(email.text, password.text);
                    if(result==null)
                    {
                   setState(() {
                      error="could not sign in with those credentials";
                   });
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
