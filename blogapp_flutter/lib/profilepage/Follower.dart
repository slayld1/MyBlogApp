import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FollowersPage extends StatefulWidget {
  final String? userEmail;

  FollowersPage({this.userEmail});

  @override
  _FollowersPageState createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  List<String> followers = [];

  @override
  void initState() {
    super.initState();
    fetchFollowers();
  }

  void fetchFollowers() async {
   var url = Uri.parse("http://192.168.1.103/uploads/followers.php");
var response = await http.post(url, body: {'user_email': widget.userEmail});


    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        followers = List<String>.from(data['followers']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Takip Ettiklerim'),
      ),
      body: followers.length == 0
          ? Center(
              child: Text('Henüz takip ettiğiniz kullanıcı bulunmamaktadır.'),
            )
          : ListView.builder(
              itemCount: followers.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        child: Icon(Icons.person),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            followers[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
