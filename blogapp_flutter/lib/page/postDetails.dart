import 'package:flutter/material.dart';
class PostDetails extends StatelessWidget {
 // const PostDetails({super.key});
  final title;
  final image;
  final body;
  final author;
  final post_date;
  PostDetails(this.title,this.image,this.body,this.author,this.post_date);

  @override
  Widget build(BuildContext context) {
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
                  decoration: InputDecoration(labelText: 'Enter comments'),
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
          ),
      ),
    );
  }
}