import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UnSeenNotificationPage extends StatefulWidget {
  const UnSeenNotificationPage({super.key});

  @override
  State<UnSeenNotificationPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<UnSeenNotificationPage> {
  List allUnSeenNotification = List.empty();
  Future getUnSeenNotification() async {
    var url =
        Uri.parse("http://192.168.1.103/uploads/selectUnSeenNotification.php");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      setState(() {
        allUnSeenNotification = jsonData;
      });
      print(allUnSeenNotification);
    }
  }

  Future updateNotification(String id) async {
    var url =
        Uri.parse("http://192.168.1.103/uploads/updateNotificationSeen.php");
    var response = await http.post(url, body: {'id': id});
    if (response.statusCode == 200) {
      print('ok');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUnSeenNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: ListView.builder(
          itemCount: allUnSeenNotification.length,
          itemBuilder: (context, index) {
            var list = allUnSeenNotification[index];
            return Card(
              color:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
              child: ListTile(
                title: Text(list['comment']),
                trailing: IconButton(
                  icon: Text(
                    "Read",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    updateNotification(list['id'].toString())
                        .whenComplete(() => getUnSeenNotification());
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
