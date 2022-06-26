import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:post/screens/post.dart';

class ListPosts extends StatefulWidget {
  const ListPosts({Key? key}) : super(key: key);

  @override
  State<ListPosts> createState() => _ListPostsState();
}

class _ListPostsState extends State<ListPosts> {
  Stream stream = FirebaseFirestore.instance.collection('post').snapshots();

  final ValueNotifier<String> _searchName = ValueNotifier<String>('');
  final ValueNotifier<String> _searchColor = ValueNotifier<String>('');
  final ValueNotifier<String> _searchCategory = ValueNotifier<String>('');

  changestream(ValueNotifier _searchName, ValueNotifier _searchColor,
      ValueNotifier _searchCategory) {
    if (_searchName.value != "" &&
        _searchColor.value == "" &&
        _searchCategory.value == "") {
      return FirebaseFirestore.instance
          .collection('post')
          .where("searchnamekeywords", arrayContains: _searchName.value)
          .snapshots();
    } else if (_searchColor.value != "" &&
        _searchName.value == "" &&
        _searchCategory.value == "") {
      return FirebaseFirestore.instance
          .collection('post')
          .where("color", isEqualTo: _searchColor.value)
          .snapshots();
    } else if (_searchCategory.value != "" &&
        _searchName.value == "" &&
        _searchColor.value == "") {
      return FirebaseFirestore.instance
          .collection('post')
          .where("category", isEqualTo: _searchCategory.value)
          .snapshots();
    } else if (_searchName.value != "" &&
        _searchColor.value != "" &&
        _searchCategory.value != "") {
      return FirebaseFirestore.instance
          .collection('post')
          .where("searchnamekeywords", arrayContains: _searchName.value)
          .where("color", isEqualTo: _searchColor.value)
          .where("category", isEqualTo: _searchCategory.value)
          .snapshots();
    } else if (_searchName.value != "" &&
        _searchColor.value != "" &&
        _searchCategory.value == "") {
      return FirebaseFirestore.instance
          .collection('post')
          .where("searchnamekeywords", arrayContains: _searchName.value)
          .where("color", isEqualTo: _searchColor.value)
          .snapshots();
    } else if (_searchName.value != "" &&
        _searchColor.value == "" &&
        _searchCategory.value != "") {
      return FirebaseFirestore.instance
          .collection('post')
          .where("searchnamekeywords", arrayContains: _searchName.value)
          .where("category", isEqualTo: _searchCategory.value)
          .snapshots();
    } else if (_searchName.value == "" &&
        _searchColor.value != "" &&
        _searchCategory.value != "") {
      return FirebaseFirestore.instance
          .collection('post')
          .where("category", isEqualTo: _searchCategory.value)
          .where("color", isEqualTo: _searchColor.value)
          .snapshots();
    } else {
      return FirebaseFirestore.instance.collection('post').snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                  child: const Text(
                    "Add Post",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            // TaskCardWidget(id: user.id, name: user.ingredients,)
                            Post()));
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextField(
              decoration: const InputDecoration(hintText: 'Search Name...'),
              onChanged: (val) {
                _searchName.value = val;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextField(
              decoration: const InputDecoration(hintText: 'Search Color...'),
              onChanged: (val) {
                _searchColor.value = val;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextField(
              decoration: const InputDecoration(hintText: 'Search Category...'),
              onChanged: (val) {
                _searchCategory.value = val;
              },
            ),
          ),
          Expanded(
            child: AnimatedBuilder(
                animation: _searchName,
                builder: (BuildContext context, Widget? child) {
                  return AnimatedBuilder(
                      animation: _searchColor,
                      builder: (BuildContext context, Widget? child) {
                        return AnimatedBuilder(
                            animation: _searchCategory,
                            builder: (BuildContext context, Widget? child) {
                              return StreamBuilder(
                                stream: changestream(
                                    _searchName, _searchColor, _searchCategory),
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                  return ListView.builder(
                                    itemCount: snapshot.data?.docs.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          title: Text(
                                            snapshot.data!.docs[index]['name']
                                                .toString(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Color - ${snapshot.data!.docs[index]['color'].toString()}",
                                              ),
                                              Text(
                                                "Category - ${snapshot.data!.docs[index]['category'].toString()}",
                                              ),
                                              Text(
                                                "Type - ${snapshot.data!.docs[index]['type'].toString()}",
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            });
                      });
                }),
          ),
        ],
      )),
    );
  }

  @override
  void dispose() {
    _searchColor.dispose();
    _searchName.dispose();
    _searchCategory.dispose();
    super.dispose();
  }
}
