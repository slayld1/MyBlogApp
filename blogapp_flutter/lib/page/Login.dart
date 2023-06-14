import 'dart:convert';

import 'package:blogapp_flutter/main.dart';
import 'package:blogapp_flutter/page/Signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../admin/Dashboard.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController user=TextEditingController();
  TextEditingController pass=TextEditingController();

  Future login() async {
    var url = Uri.parse("http://192.168.1.103/uploads/login.php");
    var response = await http.post(url, body: {
      'username': user.text,
      'password': pass.text,
    });
    if (response.statusCode == 200) {
      var user = json.decode(response.body);
      print(user);
      if (user == "ERROR") {
        showDialog(
          context: (context),
          builder: (context) => AlertDialog(
            content: Text('Invalid Username and password'),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom
              (
                primary: Colors.red,
              ),
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
        print("Username & Password Invalid");
      } else 
      {   
         if(user['status']=="Admin")
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard(name: user['name'],username:user['username'],)));
        }
        else
        
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(name:user['username'],email: user['name'] ,),));
        }
        
        showDialog(
          context: (context),
          builder: (context) => AlertDialog(
            content: Text('Login successful'),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom
              (
                primary: Colors.red,
              ),
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      }
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text('Login'),
      
      ),
      body:Stack
      (
        children: 
        [
          Container
          (
            color: Colors.grey[100],
          ),
          
          Positioned(
            top: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Login Here',style: TextStyle(fontFamily: 'Nasalization',fontSize: 30),),
            )),
            Positioned(
              top:200 ,
              child: Container
              (
                width: MediaQuery.of(context).size.width,
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                controller: user,
                decoration: InputDecoration(
                labelText: 'Username',
                ),
                ),
              ),
              )),
               Positioned(
              top:270 ,
              child: Container
              (
                width: MediaQuery.of(context).size.width,
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: pass,
                decoration: InputDecoration(
                labelText: 'Password',
                ),
                ),
              ),
              )),

               Positioned(
              top:350 ,
              child: Container
              (
                width: MediaQuery.of(context).size.width,
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  color: Colors.pink,
                  child: Text('Login',style: TextStyle(color: Colors.white),),
                  onPressed:()
                  {
                    login();
                  }),
              ),
              )),
        
         Positioned(
              top:420 ,
              child: Container
              (
                width: MediaQuery.of(context).size.width,
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                
                  child: Text('Or Sign Up',style: TextStyle(color: Colors.pink),),
                
              ),
              )),
    Positioned(
              top:480 ,
              child: Container
              (
                width: MediaQuery.of(context).size.width,
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                 
                  child: Text('Click Me for Sign Up',style: TextStyle(color: Colors.grey),),
                  onPressed:()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(),));
                  }),
              ),
              )),
        
              
        
        ],
      ),
    );
  }
}