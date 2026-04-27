import 'dart:io';
import 'package:flutter/material.dart';
import '../Core/utils/database.dart';
import 'package:image_picker/image_picker.dart';

class EditCard extends StatefulWidget {
  final String name;
  final String title;
  final String description;

  const EditCard({
    super.key,
    required this.name,
    required this.title,
    required this.description,
  });

  @override
  State<EditCard> createState() => _EditCardState();
}

class _EditCardState extends State<EditCard> {
  TextEditingController nameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  File? image;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    nameController.text = widget.name;
    titleController.text = widget.title;
    descriptionController.text = widget.description;
  }

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        image = File(picked.path);
      });
    }
  }

  Future<bool> updateCard() async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.update(
      'card',
      {
        'name': nameController.text,
        'title': titleController.text,
        'description': descriptionController.text,
      },
      where: 'id = ?',
      whereArgs: [1],
    );

    return result > 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      appBar: AppBar(
        title: const Text('Edit Card'),
        backgroundColor: Colors.pinkAccent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // white background
          Positioned(
            top: 180,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.white,
            ),
          ),

          // image section
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: image != null
                        ? FileImage(image!)
                        : const AssetImage('assets/images/shefa.jpeg')
                    as ImageProvider,
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: pickImage,
                    child: const Text(
                      'Change Picture',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // FORM (IMPORTANT FIX HERE 👇)
          Positioned(
            top: 300,
            left: 20,
            right: 20,
            bottom: 20,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Name",
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter your name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text("Job Title",
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: 'Enter your job title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text("Description",
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Enter your description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Center(
                    child: TextButton(
                      onPressed: () async {
                        try {
                          await updateCard();

                          if (mounted) {
                            Navigator.pop(context, true);
                          }
                        } catch (e) {
                          print("UPDATE ERROR: $e");
                        }
                      },
                      child: const Text(
                        "Update",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.pinkAccent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}