import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FollowingPage extends StatefulWidget {
  final String? name;

  FollowingPage({this.name});

  @override
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  List<String> following = [];

  @override
  void initState() {
    super.initState();
    fetchFollowing();
  }

  void fetchFollowing() async {
    // Takip edilenleri sunucudan almak için PHP API'yi çağırın
    var url = Uri.parse("http://192.168.1.103/uploads/following.php");
var response = await http.post(url, body: {'user_email': widget.name});


    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        following = List<String>.from(data['following']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Takipçilerim'),
      ),
      body: following.length == 0
          ? Center(
              child: Text('Henüz sizi takip eden kullanıcı bulunmamaktadır.'),
            )
          : ListView.builder(
              itemCount: following.length,
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
                            following[index],
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
