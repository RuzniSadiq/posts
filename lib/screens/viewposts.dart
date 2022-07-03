import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewPosts extends StatefulWidget {
  String id;

  ViewPosts({Key? key, required this.id}) : super(key: key);

  @override
  State<ViewPosts> createState() => _ViewPostsState();
}

class _ViewPostsState extends State<ViewPosts> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('post')
                  .doc(widget.id)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (!snapshot.hasData) {
                  return new Text("Loading");
                } else {
                  var userDocument = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Post Details",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        Text("ID: ${widget.id}"),
                        Text("Name: ${userDocument["name"]}"),
                        Text("Category: ${userDocument["category"]}"),
                        Text("Type: ${userDocument["type"]}"),
                        Text("Color: ${userDocument["color"]}"),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    ));
  }
}
