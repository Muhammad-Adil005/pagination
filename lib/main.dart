import 'package:flutter/material.dart';
import 'package:pagination_app/with_bloc/repository/repository.dart';
import 'package:pagination_app/with_bloc/view/home_screen.dart';

/*
Pagination in Flutter is a feature that allows users to view large sets of data in smaller,
manageable chunks. Pagination is commonly used in scenarios where loading all the data at once
would be impractical or slow, such as in social media feeds, search results, or product listings.
*/

void main() {
  // Create an instance of Repository
  final repository = Repository();
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final Repository repository;
  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pagination App',
      home: BlocHomeScreen(repository: repository),
    );
  }
}
