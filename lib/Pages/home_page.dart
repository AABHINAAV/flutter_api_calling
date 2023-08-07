import 'package:b_api_calling/Models/posts.dart';
import 'package:b_api_calling/Utils/api_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("app bar title"),
      ),
      body: FutureBuilder(
        future: ApiProvider.getPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Post> posts = snapshot.data ?? [];
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text((posts[index].id).toString()),
                  ),
                  title: Text(posts[index].title.substring(0, 10)),
                  trailing: Text(posts[index].body.substring(0, 10)),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
