import 'dart:convert';
import 'dart:io';
import 'package:blogapp_flutter/page/Login.dart';
import 'package:blogapp_flutter/page/Signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class PostDetails extends StatefulWidget {

  final id;
  final title;
  final image;
  final body;
  final author;
  final post_date;
  final userEmail;

  PostDetails({
    this.id,
    this.title,
    this.image,
    this.body,
    this.author,
    this.post_date,
    this.userEmail = "",
  });

  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  List<String> followedUsers = [];

bool isFollowing =false;
  TextEditingController commentsController = TextEditingController();
  String comment = "";
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;


  String isLikeOrDislike = "";
  void followUser() async {
  var response = await http.post(
    Uri.parse("http://192.168.1.103/uploads/Follow.php"),
    body: {
      "user_email": widget.userEmail,
      "followed_user_email": widget.author,
    },
  );

  if (response.statusCode == 200) {
    setState(() {
      isFollowing = true;
    });
    Fluttertoast.showToast(msg: "Kullanıcıyı takip ediyorsunuz");
  } else {
    Fluttertoast.showToast(msg: "Takip işlemi sırasında bir hata oluştu");
  }
}

void checkIsFollowing() async {
  var response = await http.post(
    Uri.parse("http://192.168.1.103/uploads/CheckFollow.php"),
    body: {
      "user_email": widget.userEmail,
      "followed_user_email": widget.author,
    },
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    var isFollowingValue = data['isFollowing'];

    setState(() {
      isFollowing = (isFollowingValue == 1);
    });
  } else {
    Fluttertoast.showToast(msg: "Takip durumu kontrol edilemedi");
  }
}




  Future addLike() async {
    var url = Uri.parse("http://192.168.1.103/uploads/addLike.php");

    var response = await http.post(url, body: {
      "user_email": widget.userEmail,
      "post_id": widget.id,
    });

    if (response.statusCode == 200) {
     print('Thanks');
     setState(() {
       isLikeOrDislike="ONE";
     });
    }
    
    
  }
  Future getLikes() async {
    var url = Uri.parse("http://192.168.1.103/uploads/selectLike.php");

    var response = await http.post(url, body: {
      "user_email": widget.userEmail,
      "post_id": widget.id,
    });

    if (response.statusCode == 200) {
      //Fluttertoast.showToast(msg: "Like sent successfully");
      var data =jsonDecode(response.body);
      setState(() 
      {
        isLikeOrDislike=data[0];
        
      });
    }
    print(isLikeOrDislike);
  }
  void initState()
  {
    super.initState();
    getLikes();
    checkIsFollowing();
    flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
    var android=AndroidInitializationSettings("@mipmap/ic_launcher");
      var ios=DarwinInitializationSettings();
      var initiliaze=InitializationSettings(android: android,iOS:ios );
      flutterLocalNotificationsPlugin.initialize(initiliaze, onDidReceiveNotificationResponse :  onSelectNotification);

  }
 Future<void> onSelectNotification(NotificationResponse? payload) async {
  if (payload != null ) {
    debugPrint("Notification: $payload");
  }
}


  Future showNotification()async
  {
    var android=AndroidNotificationDetails('channelId', 'channelName');
    var ios=DarwinNotificationDetails();
    var platform=NotificationDetails(android: android,iOS:ios);
    flutterLocalNotificationsPlugin.show(0, 'Blog Notification', this.comment, platform,payload: 'some details');
  }

  Future addComments() async {
    var url = Uri.parse("http://192.168.1.103/uploads/addComments.php");

    var response = await http.post(url, body: {
      "comment": comment,
      "user_email": widget.userEmail,
      "post_id": widget.id,
    });

    if (response.statusCode == 200) {
      showNotification();
      Fluttertoast.showToast(msg: "Comments sent successfully");
      Navigator.pop(context);
    }
  }
@override
 /* void initState() {
    // TODO: implement initState
    super.initState();
    getLikes();
  }*/
  @override
  Widget build(BuildContext context) {
    ratingAlert(String msg)
    {
      showDialog(
          context: (context),
          builder: (context) => AlertDialog(
            title: Text("Rating Status"),
            content: Text(msg,style: TextStyle(fontSize: 40),),
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Details"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Nasalization',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 22),
            Container(
              child: Image.network(
                widget.image,
                height: 250,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  widget.body,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Nasalization',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
            child:  Row(
  children: <Widget>[
    isLikeOrDislike == "ONE"
      ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              addLike().whenComplete(() => getLikes());
            },
            child: Text(
              'Unlike',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        )
      : IconButton(
          onPressed: () {
            if (widget.userEmail == "") {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Message'),
                  content: Text("Login first then try again."),
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                      child: Text("Login"),
                    )
                  ],
                ),
              );
            }
            else
            {
              addLike();
            }
          },
          icon: Icon(Icons.thumb_up),
          color: Colors.green,
        ),
    isLikeOrDislike == "ZERO"
      ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {},
            child: Text(
              'Undislike',
              style: TextStyle(color: Colors.red),
            ),
          ),
        )
      : IconButton(
          onPressed: () {
            if (widget.userEmail == "") {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Message'),
                  content: Text("Login first then try again."),
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                      child: Text("Login"),
                    )
                  ],
                ),
              );
            }
            else
            {
              addLike().whenComplete(() => getLikes());
            }
          },
          icon: Icon(Icons.thumb_down),
          color: Colors.red,
        ),

        InkWell
        (
          child: Icon(Icons.share),
          onTap: () async
          {
            await FlutterShare.share(title: widget.title,
            text: widget.body,
            linkUrl: 'https://flutter.dev/',
            chooserTitle: 'Flutter blog share',);

          },

        ),
        SizedBox(width: 50,),
        
        RatingBar.builder(
          
           onRatingUpdate: (rating)
           {
            rating==5
            ? ratingAlert('Love it!')
            :((rating<5) && (rating>3)) 
            ? ratingAlert('Its okey')
            :((rating<4) && (rating>2)) 
            ? ratingAlert('Dislike it')
            :ratingAlert('Hate it');
            
            print(rating);
           },
           direction: Axis.horizontal,
           itemCount: 5,
           initialRating: 3,
           itemSize: 30,
          
           itemBuilder:((context, index) {
             switch(index)
             {
              case 0:
              return Icon(Icons.sentiment_very_dissatisfied,
              color: Colors.red,);
              case 1:
              return Icon(Icons.sentiment_dissatisfied,
              color: Colors.redAccent);
              case 2:
              return Icon(Icons.sentiment_neutral,
              color: Colors.amber);
              case 3:
              return Icon(Icons.sentiment_satisfied,
              color: Colors.greenAccent);
              case 4:
              return Icon(Icons.sentiment_very_satisfied,
              color: Colors.green);
              
             }
            return Text("null");
           }
           ),
           
           
           ),


  ],
),
            ),
            Row(
              children: <Widget>[
                // Diğer widgetler buraya eklenir
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.author,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontFamily: 'Nasalization',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
  onPressed: () {
    followUser();
  },
  child: Text(
    isFollowing ? 'Takip Ediliyor' : 'Takip et',
  ),
),

            SizedBox(width: 5.0,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Posted on: " + widget.post_date,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontFamily: 'Nasalization',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Comment Area",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontFamily: 'Nasalization',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onSubmitted: (value) {
                        commentsController.text = value;
                      },
                      onChanged: (value) {
                        if (widget.userEmail == "") {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Message'),
                              content: Text("Login first then try again."),
                              actions: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Login(),
                                      ),
                                    );
                                  },
                                  child: Text("Login"),
                                )
                              ],
                            ),
                          );
                        } else {
                          comment = value;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter comments',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      color: Colors.amber,
                      child: Text(
                        'Publish',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        addComments();
                      },
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
} 