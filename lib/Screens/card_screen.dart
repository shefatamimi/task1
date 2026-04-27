import 'dart:io';

import 'package:flutter/material.dart';

import '../Core/utils/database.dart';
import 'edit_cardscreen.dart';
class CardScreen extends StatefulWidget {
  CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();


}

class _CardScreenState extends State<CardScreen> {
  Color colorlove = Colors.grey;
  String name = '';
  String title = '';
  String description = '';
  String description2 = 'Love design, coffee, and Flutter ☕';
  String description3 = 'Turning ideas into apps 🚀';
  File? imageFile;

  Future<void> initDefaultData() async {
    final data = await DatabaseHelper.instance.query('card');

    if (data.isEmpty) {
      final db = await DatabaseHelper.instance.database;

      await db.insert('card', {
        'id': 1,
        'name': 'Shefa AL Tamimi',
        'title': 'Flutter Developer',
        'description': 'Just building things with code 💻✨',
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Profile Card'),
          backgroundColor: Colors.grey[200],
          elevation: 0,
        ),
        body: Stack(
            children: [
              Positioned(
                top: 80,
                left: 30,
                child: Container(
                  height:550,
                  width: 300,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                      ),
                    ] ,
                    color: Colors.white70,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(36),
                      topLeft: Radius.circular(36),
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36),
                    ),
                  ),

                ),
              ),
              Positioned(
                top: 95,
                left: 266,
                child: InkWell(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditCard()),
                    );

                    if (result != null) {
                      setState(() {
                        name = result["name"] ?? name;
                        title = result["title"] ?? title;
                        description = result["description"] ?? description;

                        if (result["image"] != null) {
                          imageFile = result["image"] as File;
                        }
                      });
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 1),
                          )
                        ]
                    ),
                    child: Icon(Icons.edit,color: Colors.pinkAccent,size: 30,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 95,
                right: 238,
                child: Container(
                    child: Center(
                      child: Row(
                        children: [
                          SizedBox(width: 7,),
                          Icon(Icons.stars_sharp,color: Colors.black87,size: 20,),
                          SizedBox(width: 5),
                          Text('PRO',style: TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),),
                        ],
                      ),
                    ),
                    height: 47,
                    width: 80,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 1),
                        )
                      ],
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.orange[300],
                    )
                ),
              ),
              Positioned(
                bottom: 66,
                left: 290,
                child: InkWell(
                  onTap: (){
                    setState(() {
                      if(colorlove==Colors.red){
                        colorlove=Colors.grey;
                      }else
                        colorlove=Colors.red;
                    });

                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow:[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 1),
                          )
                        ]
                    ),
                    child: Center(
                      child: Icon(Icons.favorite,color: colorlove,size: 35,
                      ),
                    ),
                  ),
                ),
              ),

              Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height:200,
                      width: 200,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: imageFile != null
                            ? FileImage(imageFile!)
                            : AssetImage('assets/images/shefa.jpeg') as ImageProvider,
                      )
                  ),
                  SizedBox(height: 20,),
                  Text('$name',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(height: 10,),
                  Text('$title',style: TextStyle(
                      fontSize: 15,
                      color: Colors.pinkAccent.shade400

                  ),),
                  SizedBox(height: 10,),
                  Text('$description',style: TextStyle(
                    fontSize: 10,

                  ),),
                  Text('$description2',style: TextStyle(
                    fontSize: 10,

                  ),),
                  Text('$description3',style: TextStyle(
                    fontSize: 10,

                  ),),
                  SizedBox(height: 40,),
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 60), // padding
                          Text("128",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                          SizedBox(width: 20),
                          Container(height: 40, width: 2, color: Colors.grey),
                          SizedBox(width: 40),
                          Text("2.4K",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),),
                          SizedBox(width: 40),
                          Container(height: 40, width: 2, color: Colors.grey),
                          SizedBox(width: 20),
                          Text("180",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),),
                        ],
                      )

                    ],
                  ),
                  SizedBox(height: 1,),
                  Row(
                      children: [
                        SizedBox(width: 58), // padding
                        Text("Followers",style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),),
                        SizedBox(width: 55),
                        Text("Following",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black38,
                          ),),
                        SizedBox(width: 65),
                        Text("Likes",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black38,
                          ),),
                      ]
                  ),
                ],

              ),
            ]
        )

    );



  }
}


