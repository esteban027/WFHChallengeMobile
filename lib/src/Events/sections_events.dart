import '../Events/pages_events.dart';

class FetchAllGenresSections extends BasicPageEvent {
  FetchAllGenresSections([int page = 1]) : super(page);
}

class FetchAllHomeSections extends BasicPageEvent {
  FetchAllHomeSections([int page = 1]) : super(page);
}


