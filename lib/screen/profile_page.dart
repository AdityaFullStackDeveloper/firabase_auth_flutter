import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
    final ImagePicker _picker = ImagePicker();

    Future<void> saveImageUrl(String imageUrl) async {
      try {
        final fireStore = FirebaseFirestore.instance;
        await fireStore.collection("images").add({"imageUrl": imageUrl});
      } catch (error) {
        print('Error to save image:$error');
      }
    }

    Future<void> imageStore(XFile image) async {
      try {
        final storageRef = FirebaseStorage.instance.ref();
        final imageReference = storageRef.child("images");

        await imageReference.putFile(File(image.path));

        String imageUrl = await imageReference.getDownloadURL();
        saveImageUrl(imageUrl);
      } catch (error) {
        print('Error to upload image:$error');
      }
    }

    Future<void> pickImage() async {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imageStore(image);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile Page', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.teal,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Aditya kumar'),
              accountEmail: Text('aditya@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('images/rohitSharma.jpg'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firebaseFireStore.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No user data available"));
          }

          final userList = snapshot.data!.docs;

          return ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              final userDocument = userList[index];
              final userData = userDocument.data() as Map<String, dynamic>;
              return Card(
                color: Colors.white,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    "Name: ${userData['userName'] ?? 'No Name'}",
                  ),
                  subtitle: Text(
                    "Email: ${userData['userEmail'] ?? 'No Email'}",
                  ),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            showUpdateDialog(
                              context,
                              userDocument.id,
                              userData,
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.teal,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteUsers(context, userDocument.id);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void deleteUsers(BuildContext context, String docId) async {
    final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

    try {
      await firebaseFireStore.collection('users').doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User deleted successfully')));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete user: $error')),
      );
    }
  }

  void showUpdateDialog(
      BuildContext context, String docId, Map<String, dynamic> userData) {
    final TextEditingController nameController =
        TextEditingController(text: userData['userName']);
    final TextEditingController emailController =
        TextEditingController(text: userData['userEmail']);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update User'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    updateUser(
                      context,
                      docId,
                      nameController.text.trim(),
                      emailController.text.trim(),
                    );
                    Navigator.of(context).pop();
                  },
                  child: const Text('Update')),
            ],
          );
        });
  }

  void updateUser(
      BuildContext context, String docId, String name, String email) async {
    final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

    if (name.isNotEmpty && email.isNotEmpty) {
      try {
        await firebaseFireStore
            .collection('users')
            .doc(docId)
            .update({'userName': name, 'userEmail': email});
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User data updated successfully')));
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update user: $error')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid name and email')),
      );
    }
  }
}
