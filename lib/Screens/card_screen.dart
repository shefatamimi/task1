import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../Core/utils/database.dart';
import 'edit_cardscreen.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  Color colorlove = Colors.grey;

  File? imageFile;

  TextEditingController nameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initDefaultData();
    loadCard();
  }

  Future<void> initDefaultData() async {
    final data = await DatabaseHelper.instance.query('card');

    if (data.isEmpty) {
      final db = await DatabaseHelper.instance.database;

      await db.insert(
        'card',
        {
          'name': 'Shefa',
          'title': 'Flutter',
          'description': 'dev',
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<void> loadCard() async {
    final data = await DatabaseHelper.instance.query('card');

    if (data.isNotEmpty) {
      setState(() {
        nameController.text = data[0]['name'];
        titleController.text = data[0]['title'];
        descriptionController.text = data[0]['description'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Profile Card'),
        backgroundColor: Colors.grey[200],
        elevation: 0,
      ),
      body: Stack(
        children: [
          // CARD
          Positioned(
            top: 80,
            left: 30,
            child: Container(
              height: 550,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(36),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 7,
                  ),
                ],
              ),
            ),
          ),

          // EDIT BUTTON
          Positioned(
            top: 95,
            left: 266,
            child: InkWell(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditCard(
                      name: nameController.text,
                      title: titleController.text,
                      description: descriptionController.text,
                    ),
                    fullscreenDialog: true,
                    maintainState: true,
                  ),
                );

                if (result == true) {
                  await loadCard();
                  print("UPDATED");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Profile Updated ✔"),
                    ),);

                }
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                    )
                  ],
                ),
                child: const Icon(Icons.edit, color: Colors.pinkAccent),
              ),
            ),
          ),

          // ❤️ LOVE BUTTON (نفس ديزاينك)
          Positioned(
            bottom: 66,
            left: 290,
            child: InkWell(
              onTap: () {
                setState(() {
                  colorlove =
                  colorlove == Colors.red ? Colors.grey : Colors.red;
                });
              },
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 1),
                    )
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.favorite,
                    color: colorlove,
                    size: 35,
                  ),
                ),
              ),
            ),
          ),

          // CONTENT
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: imageFile != null
                      ? FileImage(imageFile!)
                      : const AssetImage('assets/images/shefa.jpeg')
                  as ImageProvider,
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: nameController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: "Enter your name",
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: titleController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: "Enter your job title",
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.pinkAccent,
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: descriptionController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: "Enter your description",
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 10),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Profile Saved ✔"),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              ],

            ),
          ),
        ],
      ),
    );
  }
}