import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String username;
  final String text;

  Comment({
    required this.username,
    required this.text,
  });
}

class Komen extends StatefulWidget {
  const Komen({Key? key}) : super(key: key);

  @override
  _KomenState createState() => _KomenState();
}

class _KomenState extends State<Komen> {
  final TextEditingController _commentController = TextEditingController();

  Future<void> _addComment(String username, String text) async {
    try {
      await FirebaseFirestore.instance.collection('comments').add({
        'username': username,
        'text': text,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _commentController.clear();
    } catch (e) {
      print('Error adding comment: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
        foregroundColor: Color(0xffedfcdc),
        backgroundColor: Color(0xff88a26a),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('comments').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<Comment> comments = snapshot.data!.docs.map((doc) {
                  Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                  return Comment(
                    username: data['username'],
                    text: data['text'],
                  );
                }).toList();

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    Comment comment = comments[index];
                    return ListTile(
                      title: Text(comment.username),
                      subtitle: Text(comment.text),
                    );
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(hintText: 'Add a comment'),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      _addComment('Username', _commentController.text);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}