//import 'package:blogapp_flutter/components/TopPostCard.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:blogapp_flutter/page/ContactUs.dart';
import 'package:blogapp_flutter/page/Login.dart';
import 'package:blogapp_flutter/page/aboutUs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'components/TopPostCard.dart';
import 'components/CategoryListItem.dart';
import 'components/RecentPostItem.dart';
import 'components/TopPostCard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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

   final name;
   final email;
   MyHomePage( 
   {
    this.name="Guest",
    this.email=""
   });
 
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   var curdate = DateFormat('MMM d, yyyy').format(DateTime.now());
 List searchList = [];
  
  Future ShowAllPost()async
  {
    var url=Uri.parse("http://192.168.1.105/uploads/postAll.php");
    var response=await http.get(url,headers: {"Accept":"application/json"});
    if (response.statusCode==200)
    {
      var jsonData= jsonDecode(response.body);
      for(var i=0; i<jsonData.length;i++)
      {
        searchList.add(jsonData[i]['title']);

      }
      print(searchList);
      //return jsonData;
    }}
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ShowAllPost();
  }
  @override
  Widget build(BuildContext context) {


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
              accountName: Text("Hi "+widget.name),
              accountEmail: Text(widget.email)),
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
              Navigator.push(context, MaterialPageRoute(builder: (context) =>AboutUs() ,),);
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
          const SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: 
            ()
             {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>ContactUs() ,),);
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
          
          
         // widget.name=="Guest"?
          
          
          
          ListTile(
            onTap: () {
              if(widget.name=="Guest")
              {
                debugPrint("giriş yap");
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
              }
              else
              {
                debugPrint("çıkış yap");
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
              }
            },
            leading: Icon(
              widget.name == "Guest" ? Icons.login : Icons.logout,
            color: widget.name == "Guest" ? Colors.red : Colors.green,
             
            ),
            title: Text(
              widget.name == "Guest" ? 'Giriş Yap' : 'Çıkış Yap',
            style: TextStyle(
              color: widget.name == "Guest" ? Colors.red : Colors.green,),
            ),
          ),
           
           
           
            /*const SizedBox(
            height: 10,
          ) ,
          ListTile(
            onTap: () {
              debugPrint("Çıkış Yap");
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
            },
            leading: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: Text(
              'Çıkış Yap',
              style: TextStyle(color: Colors.green),
            ),
          ),*/
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
          IconButton(onPressed: ()
          {
            showSearch(context: context, delegate: SearchPost(list: searchList));
          }, icon: Icon(Icons.search)),
          Container
          (
            width: 150,
            height: 50,

          ),
          /*TextField
          (
            decoration: InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(Icons.search,color: Colors.grey,)
              ),
          )*/
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
        TopPostCard(userEmail: widget.email,),
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



class SearchPost extends SearchDelegate<String>
{
  List<dynamic> list;
  SearchPost({required this.list,});
  
 
  
  Future ShowAllPost()async
  {
    var url=Uri.parse("http://192.168.1.105/uploads/SearchPost.php");
    var response=await http.post(url,body: {'title':query});
    if (response.statusCode==200)
    {
      var jsonData= jsonDecode(response.body);
      return jsonData;
    }}

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
       IconButton(onPressed: ()
       {
          query="";
          showSuggestions(context);
       }, icon: Icon(Icons.close)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: ()
    {
      close(context, "null");
    }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
   
   return FutureBuilder(
    future: ShowAllPost(),
    builder: ((context, snapshot) {
     if(snapshot.hasData)
     {
      return ListView.builder(
       itemCount: snapshot.data.length,
        itemBuilder: (context,index)
      {
        var list = snapshot.data[index];
        return Column
        (
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(padding: const EdgeInsets.all(8.0),
              child: Text(list['title'],style: TextStyle(fontSize: 25,fontFamily: 'Nasalization',fontWeight: FontWeight.bold),
              ),
              ),
               Center(
                 child: Container
                             (
                  child: Image.network('http://192.168.1.105/uploads/${list['image']}',height: 250,),
                   
                             ),
               ),
              Padding(padding: const EdgeInsets.all(8.0),
              child: Text
              (
                list['body']==null? "":list['body'],
                style: TextStyle(fontSize: 20),
              ),
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                
                  child: Text(list['author'],style: TextStyle(fontSize: 16,color: Colors.grey,fontFamily: 'Nasalization',fontWeight: FontWeight.bold),
                
                           
                   
                ),
              ),
               SizedBox(width: 5.0,),
                 Padding(
                padding: const EdgeInsets.all(8.0),
                
                  child: Text("Posted on:   " +   list['post_date'],style: TextStyle(fontSize: 16,color: Colors.grey,fontFamily: 'Nasalization',fontWeight: FontWeight.bold),
                
                           
                ), 
                ),
                SizedBox(height: 20,),
                Padding(
                padding: const EdgeInsets.all(8.0),
                
                  child: Text("Comment Area",style: TextStyle(fontSize: 16,color: Colors.grey,fontFamily: 'Nasalization',fontWeight: FontWeight.bold),
                
                           
                ), 
                ),
                Container
                (
            child: Column(children: 
            [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: TextField
                  (
                    decoration: InputDecoration(labelText: 'Enter comments'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:MaterialButton
                (
                  color: Colors.amber,
                  child: Text('Publish',style: TextStyle(color: Colors.white),),
                  onPressed: (){},
                ),
              )
            ]),                  
                )
          ],
        );
      });
     }
   return CircularProgressIndicator();
   }
   
   
    ),
   
   );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var listData=query.isEmpty? list:list.where((element) => element.toLowerCase().contains(query)).toList();
    return listData.isEmpty? Center(child: Text("No data found")): ListView.builder(
      itemCount: list.length,
      itemBuilder: (context,index)
    {
      return ListTile 
      (
        onTap: ()
        {
          query=listData[index];
          showResults(context);
        },
        title:Text(listData[index]),
      );
    });
  }

}