import 'package:flutter/material.dart';
class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold
    (
      appBar: AppBar
      (
        title: Text('İletişim'),
        
      ),
      body: Container
      (
        child: Center
        (
        child: Text("İletişim Sayfası",style: TextStyle(fontSize: 20),
        )
        ),

      ),
    );
  }
}