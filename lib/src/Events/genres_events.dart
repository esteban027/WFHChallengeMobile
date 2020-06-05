import '../Events/pages_events.dart';

class FetchAllGenres extends BasicPageEvent {
  FetchAllGenres([int page = 1]) : super(page);
}
