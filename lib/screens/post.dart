import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post/screens/listposts.dart';

import '../models/posts.dart';

class Post extends StatelessWidget {
  // const Post({Key? key}) : super(key: key);

  final controllerName = TextEditingController();
  final controllerType = TextEditingController();
  final controllerColor = TextEditingController();
  final controllerCategory = TextEditingController();
  List<String> searchKeywords = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controllerName,
                  decoration: InputDecoration(
                    labelText: "Name",
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 15.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controllerType,
                  decoration: InputDecoration(
                    labelText: "Type",
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 15.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controllerColor,
                  decoration: InputDecoration(
                    labelText: "Color",
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 15.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controllerCategory,
                  decoration: InputDecoration(
                    labelText: "Category",
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 15.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                minWidth: 160,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                onPressed: () async {
                  String temp = "";
                  for (var i = 0; i < controllerName.text.length; i++) {

                      temp = temp + controllerName.text[i];
                      searchKeywords.add(temp);
                  }
                  ScaffoldMessenger.of(context).showSnackBar((controllerName
                                  .text !=
                              "" &&
                          controllerColor.text != "" &&
                          controllerType.text != "" &&
                          controllerCategory.text != "")
                      ? SnackBar(
                          content: Row(
                            children: const [
                              Icon(
                                Icons.playlist_add_check,
                                color: Colors.greenAccent,
                              ),
                              SizedBox(width: 20),
                              Expanded(child: Text('Post Added Successfully!')),
                            ],
                          ),
                        )
                      : SnackBar(
                          content: Row(
                            children: const [
                              Icon(
                                Icons.playlist_add_check,
                                color: Colors.red,
                              ),
                              SizedBox(width: 20),
                              Expanded(child: Text('Post Enter Details')),
                            ],
                          ),
                        ));
                  if (controllerName.text != "" &&
                      controllerColor.text != "" &&
                      controllerType.text != "" &&
                      controllerCategory.text != "") {
                    final posts = Posts(
                      //assigning the values to the fields
                      name: controllerName.text,
                      type: controllerType.text,
                      color: controllerColor.text,
                      category: controllerCategory.text,
                      searchkeywords: searchKeywords,
                    );
                    final json = posts.toJson();
                    final docPosts =
                        FirebaseFirestore.instance.collection('post').doc();
                    //create document and write data to firebase
                    await docPosts.set(json);

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            // TaskCardWidget(id: user.id, name: user.ingredients,)
                            ListPosts()));
                  }

                  controllerName.text = "";
                  controllerType.text = "";
                  controllerColor.text = "";
                  controllerCategory.text = "";
                },
                color: Colors.black,
                child: const Text(
                  'Add Post',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
