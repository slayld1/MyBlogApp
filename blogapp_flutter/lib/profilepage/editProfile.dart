import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateProfilePage extends StatefulWidget {
  
  final String authorName;
  UpdateProfilePage( this.authorName);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _updateProfile() async {
    var url = Uri.parse("http://192.168.1.103/uploads/updateProfile.php");
    var response = await http.post(
      url,
      body: {
        
        'name': _nameController.text,
        'username': _emailController.text,
        'password': _passwordController.text,
      },
    );
    // Handle response here
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateProfile();
    
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _updateProfile();
                  }
                },
                child: Text('Update Profile'),
              ),
              // Gizli alan (hidden field) olarak kullanıcının kimliğini formda saklayın
             
            ],
          ),
        ),
      ),
    );
  }
}
