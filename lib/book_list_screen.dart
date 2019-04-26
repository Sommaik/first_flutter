import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookListScreen extends StatelessWidget {
  final Firestore _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection("books").snapshots(),
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot> snapshot,
      ) {
        if (snapshot.hasData) {
          return buildListData(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildListData(QuerySnapshot data) {
    return ListView.builder(
      itemCount: data.documents.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(data.documents[index].data["title"]),
        );
      },
    );
  }
}
