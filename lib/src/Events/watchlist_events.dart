import 'package:WFHchallenge/src/Events/post_events.dart';
import '../Events/pages_events.dart';
import '../models/watchlist_page_model.dart';

class BasicWatchlistEvent extends BasicPageEvent with PostEvent {
  BasicWatchlistEvent(int page) : super(page);
}

class AddToWatchlist extends BasicWatchlistEvent {
  WatchlistModel watchlist;
  AddToWatchlist(this.watchlist) : super(0);
}

class DeleteFromWatchlist extends BasicWatchlistEvent {
  WatchlistModel watchlist;
  DeleteFromWatchlist(this.watchlist) : super(0);
}

class FetchWatchlistByUser extends BasicWatchlistEvent {
  int userId;
  FetchWatchlistByUser(this.userId, [int page = 1] ) : super(page);
}

class CheckIfMovieIsInUserWatchlist extends BasicWatchlistEvent {
  int userId;
  int movieId;
  CheckIfMovieIsInUserWatchlist(this.userId,this.movieId) : super(0);
}



