import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_app/with_bloc/with_bloc.dart';

class BlocHomeScreen extends StatelessWidget {
  final Repository repository; // Pass Repository as a constructor argument
  const BlocHomeScreen({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(repository),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Pagination with Bloc'),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent &&
                    !state.loading &&
                    state.hasMore) {
                  // Dispatch the event to load more posts
                  context.read<HomeBloc>().add(
                      CallApi(page: (state.users.length ~/ 10) + 1, limit: 10));
                }
                return false;
              },
              child: ListView.builder(
                itemCount: state.users.length +
                    (state.hasMore
                        ? 1
                        : 0), // Show loading indicator if more posts are available
                itemBuilder: (context, index) {
                  if (index == state.users.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final post = state.users[index];
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
