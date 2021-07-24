import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tuts/UI/views/uploadPost.dart';
import 'package:tuts/UI/widgets/button.dart';
import 'package:tuts/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final Stream<QuerySnapshot> _postStream =
    FirebaseFirestore.instance.collection('posts').snapshots();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Facebook',
                    style: TextStyle(
                        color: lightBlue,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  fakeButton(
                      text: "Clone Mode",
                      textColor: Colors.white,
                      buttonColor: midGrey,
                      height: 30,
                      width: 120)
                ],
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  CircleAvatar(),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      child: TextFormField(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UploadPost()));
                        },
                        decoration: InputDecoration(
                          hintText: "Write Something",
                          hintStyle: TextStyle(color: lightGrey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 15),
            StreamBuilder<QuerySnapshot>(
              stream: _postStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return Expanded(
                  child: ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return Container(
                        child: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(),
                              title: Text("John Doe"),
                              subtitle: Text(
                                DateTime.now().toString(),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data['post']),
                                  Container(
                                    height: 200,
                                    width: double.infinity,
                                    child: Image.network(
                                      data['uploadUrl'],
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
