import 'package:flutter/material.dart';
import 'package:pagination_app/with_provider/controller/pagination_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pagination '),
      ),
      body: ChangeNotifierProvider(
        create: (_) => PostProvider()..fetchPosts(),
        child: Consumer<PostProvider>(
          builder: (context, postProvider, child) {
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent &&
                    !postProvider.isLoading) {
                  postProvider.fetchPosts();
                }
                return false;
              },
              child: ListView.builder(
                itemCount: postProvider.posts.length +
                    (postProvider.hasMore
                        ? 1
                        : 0), // Show loading indicator if there are more posts
                itemBuilder: (context, index) {
                  if (index == postProvider.posts.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final post = postProvider.posts[index];
                  return Card(
                    surfaceTintColor: Colors.transparent,
                    color: Colors.green,
                    child: ListTile(
                      title: Text(
                        post.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        post.body,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
