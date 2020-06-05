import '../Events/pages_events.dart';

class FetchRatingsByMovieId extends BasicPageEvent {
  int movieId;
  FetchRatingsByMovieId(this.movieId, [int page = 1] ) : super(page);
}
