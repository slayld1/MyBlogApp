import 'package:flutter/material.dart';
class AboutUs extends StatelessWidget
{
  Widget build(BuildContext context)
   {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text('Hakkımızda'),
        
      ),
      body: Container
      (
        child: Center
        (
        child: Text("Hakkımızda Sayfası",style: TextStyle(fontSize: 20),
        )
        ),

      ),
    );
   }
}