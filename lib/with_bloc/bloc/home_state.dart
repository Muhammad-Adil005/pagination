import 'package:equatable/equatable.dart';
import 'package:pagination_app/with_bloc/model/user_model.dart';

class HomeState extends Equatable {
  final bool loading;
  final bool hasMore;
  final List<UserModel> users;

  const HomeState({
    this.loading = false,
    this.hasMore = true,
    this.users = const [],
  });

  HomeState copyWith({
    bool? loading,
    bool? hasMore,
    List<UserModel>? users,
  }) {
    return HomeState(
      loading: loading ?? this.loading,
      hasMore: hasMore ?? this.hasMore,
      users: users ?? this.users,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        hasMore,
        users,
      ];
}
