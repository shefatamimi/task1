import 'package:flutter/material.dart';
import 'card_screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';



class EditCard extends StatefulWidget {
   EditCard({super.key});

  @override
  State<EditCard> createState() => _EditCardState();

}

class _EditCardState extends State<EditCard> {
  TextEditingController nameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController description2Controller = TextEditingController();
  TextEditingController description3Controller = TextEditingController();
  File? image;
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        image = File(picked.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Card'),
        backgroundColor: Colors.grey[200],
        elevation: 0,
      ),
      backgroundColor: Colors.pinkAccent,
      body: Stack(
        children: [
          // الكارد الأبيض
          Positioned(
            top: 180,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.white,
            ),
          ),

          //
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: image != null
                        ? FileImage(image!)
                      : AssetImage('assets/images/shefa.jpeg') as ImageProvider,
                    ),
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: pickImage,
                    child: Text(
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
          Positioned(
            top: 300,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 👈 مهم جداً
              children: [
                SizedBox(height: 20,),
                Text(
                  ' Name',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Set the border radius to 10.0
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  'job title',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Enter your job title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Set the border radius to 10.0
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Enter your description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Set the border radius to 10.0
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      "name": nameController.text,
                      "title": titleController.text,
                      "description": descriptionController.text,
                      "image": image,
                    });
                  },
                  child: Center(
                    child: Text(
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
        ],

      ),
    );
  }
}