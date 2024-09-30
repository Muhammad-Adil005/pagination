
abstract class HomeEvent{}

class CallApi extends HomeEvent{
  final int page;
  final int limit;

  CallApi({
    this.page = 1,
    this.limit = 10,
});
}