// import 'package:flutter/material.dart';
//
// class SomeModel extends StatefulWidget {
//   const SomeModel({super.key});
//
//   @override
//   State<SomeModel> createState() => _SomeModelState();
// }
//
// class _SomeModelState extends State<SomeModel> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User List'),
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(10),
//         children: [
//           UserCard(
//             name: 'SHOBHA KUMARI',
//             age: '0',
//             gender: 'F',
//             buttonColor: Colors.brown,
//           ),
//           UserCard(
//             name: 'Chhotelal Mahto',
//             age: '42',
//             gender: 'M',
//             buttonColor: Colors.brown,
//           ),
//           UserCard(
//             name: 'AADITYA KUMAR',
//             age: '0',
//             gender: 'M',
//             buttonColor: Colors.grey,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class UserCard extends StatelessWidget {
//   final String name;
//   final String age;
//   final String gender;
//   final Color buttonColor;
//
//   UserCard({
//     required this.name,
//     required this.age,
//     required this.gender,
//     required this.buttonColor,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       margin: EdgeInsets.symmetric(vertical: 8),
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Name: $name', style: TextStyle(fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Text('Age: $age', style: TextStyle(fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Text('Gender: $gender', style: TextStyle(fontWeight: FontWeight.bold)),
//             SizedBox(height: 16),
//             Align(
//               alignment: Alignment.centerRight,
//               child: ElevatedButton.icon(
//                 onPressed: () {},
//                 icon: Icon(Icons.remove_red_eye),
//                 label: Text("View"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: buttonColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class SomeModel extends StatefulWidget {
  const SomeModel({super.key});

  @override
  State<SomeModel> createState() => _SomeModelState();
}

class _SomeModelState extends State<SomeModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          height: 170,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side: User Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shobha Kumari (NOT AVAILABLE) | F/O',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                              'Aadhaar KYC',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.close, color: Colors.red, size: 14),
                                  SizedBox(width: 4),
                                  Text(
                                    'Not Verified',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Mobile No.: NA',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Member ID: 1017015001300451006803',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Aadhaar No.: XXXX-XXXX-2609',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Right side: Icons with background
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildIconButton(Icons.remove_red_eye, Colors.amber),
                      SizedBox(height: 6),
                      _buildIconButton(Icons.edit, Colors.green),
                      SizedBox(height: 6),
                      _buildIconButton(Icons.delete, Colors.red),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, Color color) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: () {},
      ),
    );
  }
}

