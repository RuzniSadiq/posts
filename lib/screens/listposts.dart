import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post/screens/post.dart';

class ListPosts extends StatefulWidget {
  const ListPosts({Key? key}) : super(key: key);

  @override
  State<ListPosts> createState() => _ListPostsState();
}

class _ListPostsState extends State<ListPosts> {
  // Initial Selected Value
  String dropdownvalue = 'All';

  Stream stream = FirebaseFirestore.instance.collection('post').snapshots();
  String name = "";


  // List of items in our dropdown menu
  var items = [
    'All',
    'Name',
    'Type',
    'Color',
    'Category',
  ];

  changestream() {
    if (dropdownvalue == "All") {
      setState(() {
        stream = FirebaseFirestore.instance.collection('post').snapshots();
      });
    } else if (dropdownvalue == "Category") {
      setState(() {
        stream = FirebaseFirestore.instance
            .collection('post')
            .orderBy('category')
            .snapshots();
      });
    } else if (dropdownvalue == "Type") {
      setState(() {
        stream = FirebaseFirestore.instance
            .collection('post')
            .orderBy('type')
            .snapshots();
      });
    } else if (dropdownvalue == "Name") {
      setState(() {
        stream = FirebaseFirestore.instance
            .collection('post')
            .orderBy('name')
            .snapshots();
      });
    } else if (dropdownvalue == "Color") {
      setState(() {
        stream = FirebaseFirestore.instance
            .collection('post')
            .orderBy('color')
            .snapshots();
      });
    } else {
      setState(() {
        stream = FirebaseFirestore.instance.collection('post').snapshots();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: TextField(
              decoration: const InputDecoration(
                  hintText: 'Search post by name...'
              ),
              onChanged: (val){
                setState(() {
                  name = val;
                });
              },

            ),
          ),
        ),
      ),
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                      child: Text(
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
                DropdownButton(
                  // Initial Value
                  value: dropdownvalue,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),

                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                      changestream();
                    });
                  },
                ),
              ],
            ),

            Expanded(
              child: StreamBuilder(
                stream:
                (name != "" && name != null)
                ? FirebaseFirestore.instance.collection('post').where("searchkeyword", arrayContains: name).snapshots()
                    :
                stream,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            "${snapshot.data!.docs[index]['name'].toString()}",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Category - ${snapshot.data!.docs[index]['category'].toString()}",
                              ),
                              Text(
                                "Type - ${snapshot.data!.docs[index]['type'].toString()}",
                              ),
                              Text(
                                "Color - ${snapshot.data!.docs[index]['color'].toString()}",
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
