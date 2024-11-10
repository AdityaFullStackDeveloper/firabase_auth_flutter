import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RealtimeDatabaseUserprofile extends StatelessWidget {
  const RealtimeDatabaseUserprofile({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'RealTime Database',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firebaseFireStore.collection('newUser').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No data available"));
          }

          final dataList = snapshot.data!.docs;

          return ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              final dataDocument = dataList[index];
              final data = dataDocument.data() as Map<String, dynamic>;

              return Card(
                color: Colors.white,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    "Name: ${data['userName'] ?? 'No User Found'}",
                  ),
                  subtitle: Text(
                    "Email: ${data['userEmail'] ?? 'No User Found'}",
                  ),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            showUpdateDialog(
                              context,
                              dataDocument.id,
                              data,
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.teal,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteData(context, dataDocument.id);
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

  void deleteData(BuildContext context, String docId) async {
    final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

    try {
      await firebaseFireStore.collection('newUser').doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data deleted successfully')));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete data: $error')),
      );
    }
  }

  void showUpdateDialog(
      BuildContext context, String docId, Map<String, dynamic> data) {
    final TextEditingController nameController =
        TextEditingController(text: data['userName']);
    final TextEditingController emailController =
        TextEditingController(text: data['userEmail']);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update Data'),
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
                    updateData(
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

  void updateData(
      BuildContext context, String docId, String name, String email) async {
    final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

    if (name.isNotEmpty && email.isNotEmpty) {
      try {
        await firebaseFireStore
            .collection('newUser')
            .doc(docId)
            .update({'userName': name, 'userEmail': email});
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data updated successfully')));
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update data: $error')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid data')),
      );
    }
  }
}
