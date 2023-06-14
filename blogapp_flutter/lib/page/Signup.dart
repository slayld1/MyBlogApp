import 'dart:convert';

import 'package:blogapp_flutter/page/Login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../admin/Dashboard.dart';
import '../main.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
TextEditingController name=TextEditingController();
 TextEditingController user=TextEditingController();
  TextEditingController pass=TextEditingController();
  Future signUp () async
  {
    var url=Uri.parse("http://192.168.1.103/uploads/register.php");

    var response= await http.post(url,body: {"name":name.text,"username":user.text,"password":pass.text});
 
    if(response.statusCode==200)
    {
      var userData=jsonDecode(response.body);
      if(userData=="ERROR")
      {
        showDialog(
          context: (context),
           builder: (context)=>AlertDialog
           (title: Text('Message'),
           content: Text('This user already exit!'),
           actions: 
           [
            ElevatedButton(
              style: ElevatedButton.styleFrom
              (
                primary: Colors.red,
              ),
              onPressed: ()
              {
                Navigator.pop(context);
              },
               child: Text('Cancel'))
           ],
           ),
           );
      }
      else
      {
        if(userData['status']=="Admin")
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
        }
        else
        
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(name: userData['name'],email: userData['email'],),));
        }
       
        showDialog(
          context: (context),
           builder: (context)=>AlertDialog
           (title: Text('Message'),
           content: Text('Signup Successful'),
           actions: 
           [
            ElevatedButton(
              style: ElevatedButton.styleFrom
              (
                primary: Colors.red,
              ),
              onPressed: ()
              {
                Navigator.pop(context);
              },
               child: Text('Cancel'))
           ],
           ),
           );
        print(userData);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text('SignUp'),
      
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
              child: Text('SignUp Here',style: TextStyle(fontFamily: 'Nasalization',fontSize: 30),),
            )),
             Positioned(
              top:130 ,
              child: Container
              (
                width: MediaQuery.of(context).size.width,
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                controller: name,
                decoration: InputDecoration(
                labelText: 'Name',
                ),
                ),
              ),
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
                  child: Text('Sign Up',style: TextStyle(color: Colors.white),),
                  onPressed:(){signUp();}),
              ),
              )),
        
         Positioned(
              top:420 ,
              child: Container
              (
                width: MediaQuery.of(context).size.width,
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                
                  child: Text('Or Sign in',style: TextStyle(color: Colors.pink),),
                
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
                 
                  child: Text('Click Me for Sign in',style: TextStyle(color: Colors.grey),),
                  onPressed:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
                  }),
              ),
              )),
        
              
        
        ],
      ),
    );
  }
}