import 'package:blogapp_flutter/page/Signup.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:fluttertoast/fluttertoast_web.dart';
import 'package:http/http.dart' as http;
class PostDetails extends StatelessWidget {
 // const PostDetails({super.key});
  final id;
  final title;
  final image;
  final body;
  final author;
  final post_date;
  final userEmail;
  PostDetails(
    {
     this.id, this.title,this.image,this.body,this.author,this.post_date
    ,this.userEmail=""});

  @override
  Widget build(BuildContext context) {
    TextEditingController commentsController=TextEditingController();
    
    
   
    Future addComments() async
    {
        var url=Uri.parse("http://192.168.1.105/uploads/addComments.php");
       
      var response = await http.post
      (url,body: {
        "comment":commentsController.text,
        "user_email":this.userEmail,
        "post_id":this.id,
        
      
      });
    if(response.statusCode==200)
    {
      Fluttertoast.showToast(msg: "Comments send sucessful");
      Navigator.pop(context);
    }
    }
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text("Post Details"),
        
        
      ),
      body: Container
      (
          child: ListView
          (
            children: <Widget>
            [ 
              Padding(padding: const EdgeInsets.all(8.0),
              child: Text(title,style: TextStyle(fontSize: 25,fontFamily: 'Nasalization',fontWeight: FontWeight.bold),
              ),
              ),
              SizedBox(height: 22,),
              Container
              (
                child: Image.network(image,height: 250,),
                 
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container
                (
                  child: Text(body,style: TextStyle(fontSize: 20,fontFamily: 'Nasalization',fontWeight: FontWeight.bold),
                ),
                   
                ),
              ),
               SizedBox(height: 20),
               Row
               (
                children: <Widget>
               [

               ],
               ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                
                  child: Text(author,style: TextStyle(fontSize: 16,color: Colors.grey,fontFamily: 'Nasalization',fontWeight: FontWeight.bold),
                
                           
                   
                ),
              ),
               SizedBox(width: 5.0,),
                 Padding(
                padding: const EdgeInsets.all(8.0),
                
                  child: Text("Posted on:   " +   post_date,style: TextStyle(fontSize: 16,color: Colors.grey,fontFamily: 'Nasalization',fontWeight: FontWeight.bold),
                
                           
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
                child: TextField
                (
                  onSubmitted: (value)
                  {
                    commentsController.text=value;
                  },
                  onChanged: (value)
                  {
                    if(this.userEmail=="")
                    {
                      showDialog(context: context, builder: (context)=>AlertDialog
                      (
                        title: Text('Message'),
                        content: Text("Login first then try again."),
                        actions: 
                        [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom
                            (primary: Colors.red,

                            ),
                            onPressed: ()
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                            }, child: Text("Login"))
                        ],
                      ));

                    }
                  },
                  decoration: InputDecoration(labelText: 'Enter comments'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:MaterialButton
                (
                  color: Colors.amber,
                  child: Text('Publish',style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    addComments();
                  },
                ),
              )
            ]),                  
                )
            ],
          ),
      ),
    );
  }
}