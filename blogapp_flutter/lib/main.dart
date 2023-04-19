//import 'package:blogapp_flutter/components/TopPostCard.dart';
import 'package:blogapp_flutter/page/ContactUs.dart';
import 'package:blogapp_flutter/page/aboutUs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'components/TopPostCard.dart';
import 'components/CategoryListItem.dart';
import 'components/RecentPostItem.dart';
import 'components/TopPostCard.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        visualDensity: VisualDensity.adaptivePlatformDensity,
       // primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
 // const MyHomePage({super.key});
   
 
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   var curdate = DateFormat('MMM d, yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {



    
   Widget menuDrawer() {
    /*return Drawer
    (
     
      child: ListView
      (
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: 
        [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration
            (
              color: Colors.pinkAccent
            ),
            currentAccountPicture: GestureDetector
            (
              
              child: CircleAvatar
              (
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
              ),
            
            ),
            
            
            accountName: Text('Sıla'),
             accountEmail: Text('silayldrm01@gmail.com')
             ),
            SizedBox(height: 10,
            width: 10,),
             Expanded(
              child:  ListTile
            
             (
              leading: Icon(Icons.home),
              title: Text('Home',style: TextStyle(color: Colors.green),),
             ),
             ),

        ],
      ),
     
    );*/
  return Drawer(
      
        
        child: 
          
          ListView(
         
          children: <Widget>[
            UserAccountsDrawerHeader(
                decoration:  BoxDecoration(color: Colors.pinkAccent),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person),
                  ),
                ),
                accountName: Text("Sıla"),
                accountEmail: Text("silayldrm01@gmail.com")),
             const SizedBox(height: 10,),
            ListTile(
              onTap: () {
                debugPrint("Ana Sayfa");
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
             const SizedBox(height: 10,),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutUs(),
                  ),
                );
                debugPrint("Hakkımızda");
              },
              leading: Icon(
                Icons.label,
                color: Colors.grey,
              ),
              title: Text(
                'Hakkımızda',
                style: TextStyle(color: Colors.grey),
              ),
            ),
             const SizedBox(height: 10,),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactUs(),
                  ),
                );
                debugPrint("İletişim");
              },
              leading: Icon(
                Icons.contacts,
                color: Colors.amber,
              ),
              title: Text(
                'İletişim',
                style: TextStyle(color: Colors.amber),
              ),
            ),
           const SizedBox(height: 10,),
            ListTile(
              onTap: () {
                debugPrint("Giriş Yap");
              },
              leading: Icon(
                Icons.login,
                color: Colors.red,
              ),
              title: Text(
                'Giriş Yap',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
          );
        
          
     
}


  

    
    
    return Scaffold
    (
      appBar: AppBar
      (
        
      iconTheme:IconThemeData(color: Colors.black),  
      backgroundColor: Colors.white,
      elevation: 1,
        actions: <Widget>
        [
          Container
          (
            width: 150,
            height: 50,

          ),
          TextField
          (
            decoration: InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(Icons.search,color: Colors.grey,)
              ),
          )
        ],
      ),
       
       drawer: menuDrawer(),
     
      body: ListView(children: <Widget>
      [
        Padding(padding: const EdgeInsets.all(8.0),
       child: Text('Blogs Today',style: TextStyle(fontSize: 25,fontFamily: 'Rubik'),),
        ),
        Row
        (
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
          children: <Widget>
        [
        
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(curdate,style: TextStyle(fontSize: 18,fontFamily:'Rubik',color: Colors.grey),),),
           Padding(padding: const EdgeInsets.all(8.0),
       child:Icon(Icons.today),
        ),
          
        ],
        ),
        TopPostCard(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(child: Text('Top Categories',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontFamily: 'Rubik'),),),
        ),
        CategoryListItem(),
        RecentPostItem(),

      ]),
    );;
  }
}