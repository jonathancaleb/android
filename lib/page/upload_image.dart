import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadViewPage extends StatefulWidget {
  const UploadViewPage({super.key});

  @override
  UploadGalleryPageState createState() => UploadGalleryPageState();
}

class UploadGalleryPageState extends State<UploadViewPage> {
  // Firebase Storage instance (assuming Firebase is already initialized)
  final FirebaseStorage storage = FirebaseStorage.instance;

  // Image picker
  final ImagePicker _picker = ImagePicker();

  // List to store uploaded image URLs
  List<String> _uploadedImages = [];

  // Map to track upload tasks for progress indication
  final Map<String, UploadTask?> _uploadTasks = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('I M A G E'),
        actions: [
          // Add a button to pick images
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: () => _pickImage(),
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _uploadedImages.isEmpty
            ? Center(child: Text('No images uploaded yet.'))
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                itemCount: _uploadedImages.length,
                itemBuilder: (context, index) {
                  final imageUrl = _uploadedImages[index];
                  return Stack(
                    children: [
                      // Image view
                      Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),

                      // Progress indicator (if upload is ongoing)
                      if (_uploadTasks.containsKey(imageUrl))
                        Center(child: CircularProgressIndicator()),
                    ],
                  );
                },
              ),
      ),
    );
  }

  // Function to pick an image from gallery or camera
  Future<void> _pickImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _uploadImage(File(pickedImage.path));
      });
    }
  }

  // Function to upload image to Firebase Storage
  Future<void> _uploadImage(File imageFile) async {
    final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final reference = storage.ref().child('uploads/$fileName');

    final uploadTask = reference.putFile(imageFile);
    setState(() {
      _uploadTasks[fileName] = uploadTask;
    });

    // Wait for the upload to finish
    await uploadTask.whenComplete(() => setState(() {
          _uploadTasks.remove(fileName);
        }));

    // Get the download URL of the uploaded image
    final imageUrl = await reference.getDownloadURL();

    setState(() {
      _uploadedImages.add(imageUrl);
    });
  }
}
