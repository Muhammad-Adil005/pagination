import 'package:flutter/material.dart';
import 'package:pagination_app/with_provider/with_provider.dart';

class PostProvider with ChangeNotifier {
  final _repoService = Repo();

  final List<User> _posts = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _page = 1;
  final int _limit = 10;

  List<User> get posts => _posts;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchPosts() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      List<User> newPosts = await _repoService.fetchPost(_page, _limit);
      if (newPosts.isEmpty) {
        _hasMore = false; // No more posts to load
      } else {
        _posts.addAll(newPosts);
        _page++; // Increment the page for the next fetch
      }
    } catch (e) {
      debugPrint("Error fetching posts: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
