import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:first/models/post_model.dart';
import 'detail_screen.dart';

class PostListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchPost(),
      builder: (context, AsyncSnapshot<List<Post>> snapshot) {
        if (snapshot.hasData) {
          return buildListView(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<List<Post>> fetchPost() async {
    http.Response response =
        await http.get("https://jsonplaceholder.typicode.com/posts");
    List<dynamic> posts = json.decode(response.body);
    return posts.map((value) {
      return Post.fromJson(value);
    }).toList();
  }

  Widget buildListView(List<Post> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(data[index].title),
          subtitle: Text(data[index].body),
          leading: Text("${data[index].id}"),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return DetailScreen(
                title: data[index].title,
              );
            }));
          },
        );
      },
    );
  }
}
