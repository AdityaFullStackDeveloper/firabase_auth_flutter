import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Profile Page",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Aditya kumar'),
              accountEmail: Text('aditya@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('images/rohitSharma.jpg'),
              ),
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
                            color: Colors.orange,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteUsers(context, userDocument.id);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.orange,
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

  void showUpdateDialog(BuildContext context, String docId,
      Map<String, dynamic> userData) {
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

  void updateUser(BuildContext context, String docId, String name,
      String email) async {
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
