import 'package:bloc/bloc.dart';
import 'package:pagination_app/with_bloc/bloc/home_event.dart';
import 'package:pagination_app/with_bloc/bloc/home_state.dart';
import 'package:pagination_app/with_bloc/repository/repository.dart';

import '../model/user_model.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Repository repository;
  HomeBloc(this.repository) : super(const HomeState()) {
    callFunction();
    add(CallApi(
        page: 1,
        limit:
            10)); // This will call this Event directly when user come to the screen
  }

  void callFunction() {
    on<CallApi>(_onCallApi);
  }

  Future<void> _onCallApi(CallApi event, Emitter<HomeState> emit) async {
    if (state.loading || !state.hasMore) return;

    emit(state.copyWith(loading: true)); // Start loading

    try {
      final response = await repository.fetchPost(event.page, event.limit);
      if (response.isEmpty) {
        // No more data available
        emit(state.copyWith(hasMore: false));
      } else {
        // Append new posts to the existing list
        final updatedUsers = List<UserModel>.from(state.users)
          ..addAll(response);

        // Emit new state with updated user list and increment page
        emit(state.copyWith(
          loading: false,
          hasMore: true,
          users: updatedUsers,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        loading: false,
      ));
      print("Error fetching posts: $e");
    }
  }
}
