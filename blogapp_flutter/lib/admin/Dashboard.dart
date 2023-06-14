import 'package:blogapp_flutter/admin/categoryDetails.dart';
import 'package:blogapp_flutter/admin/postDetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../main.dart';
import '../page/ContactUs.dart';
import '../page/Login.dart';
import '../page/UnSeenNotificationPage.dart';
import '../page/aboutUs.dart';
import 'package:badges/badges.dart' as badges;
class Dashboard extends StatefulWidget
{
  final name;
  final username;
  Dashboard
  (
    {this.name ="Guest",
    this.username=""
    });

@override
State<Dashboard> createState() =>_DashboardState();
//  _DashboardState createState()=> _DashboardState();
}
class _DashboardState extends State<Dashboard>
{
  bool isSeen=true;

  var total;
  Future getTotalUnSeenNotification()async
  {

    var url= Uri.parse("http://192.168.1.103/uploads/selectCommentNotification.php");
    var response=await http.get(url);
    if(response.statusCode==200)
    {
      setState(() {
        total=response.body;

      });
      print(total);

    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotalUnSeenNotification();
  }
  Widget build(BuildContext context)
  {
   


    Widget menuDrawer()
{
return Drawer(
  
      child: ListView(
        children: <Widget>[
          
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.pinkAccent),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person),
                ),
              ),
             
              accountName: Text("Hi "+widget.name ),
              accountEmail: Text(widget.username )),

             
          const SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>MyHomePage() ,),);
            },
            leading: Icon(
              Icons.home,
              color: Colors.green,
            ),
            title: Text(
              'Ana Sayfa',
              style: TextStyle(color: Colors.green),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>CategoryDetails() ,),);
            },
            leading: Icon(
              Icons.label,
              color: Colors.grey,
            ),
            title: Text(
              'Kategori Ekle',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: 
            ()
             {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>PostDetails(widget.name) ,),);


             },
            leading: Icon(
              Icons.contacts,
              color: Colors.blue,
            ),
            title: Text(
              'Blog Ekle',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          
          
         
          
          
          
          
           
           
           
           
          ListTile(
            onTap: () {
              
                debugPrint("çıkış yap");
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
              
            },
            leading: Icon(
               Icons.logout,
            color:  Colors.red,
             
            ),
            title: Text(
              'Çıkış Yap',
            style: TextStyle(
              color:  Colors.red,),
            ),
          ),
        ],
),
);
}
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard'),
      actions: 
      [
        isSeen?
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell
          (
            onTap: ()
            {
              
              Navigator.push(context,MaterialPageRoute(builder: (context)=>UnSeenNotificationPage()));
              
              debugPrint("seen");
            },
            child: badges.Badge
            (
              badgeContent:Text('$total',style: TextStyle(color: Colors.white),),
              child: Icon(Icons.notifications_active),
            )
          ),
        ):

        Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell
          (
            onTap: (){},
            child: badges.Badge
            (
              badgeContent:Text("0",style: TextStyle(color:Colors.white ),),
              child: Icon(Icons.notifications_none),
            )
          ),
        ),
      ],
      ),
      drawer: menuDrawer(),
      body: ListView(children: [myGridView()]),
    );
  }

Widget myGridView()
{
  return SingleChildScrollView(child: Container(
    height: 250,
    child: GridView.count(
    crossAxisSpacing: 5,
    crossAxisCount: 2,
    mainAxisSpacing: 5,
    padding: EdgeInsets.all(5),
  children: 
  [
    Container(
      color: Colors.purple,
      child: Center(child:Text("Total Post 10") ,)),
    Container(
      color: Colors.green,
      child: Center(child:Text("Total Category 15") ,)),
  ],),),);
}
}