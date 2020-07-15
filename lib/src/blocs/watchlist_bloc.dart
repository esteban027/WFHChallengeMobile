import 'package:WFHchallenge/src/Events/watchlist_events.dart';
import 'package:WFHchallenge/src/States/watchlist_states.dart';
import 'package:WFHchallenge/src/models/watchlist_page_model.dart';
import '../resources/watchlist_repository.dart';
import 'package:bloc/bloc.dart';
import '../Events/ratings_events.dart';

class WatchlistBloc extends Bloc<BasicWatchlistEvent, WatchlistState> {
  WatchlistRepository repository;

  @override
  WatchlistState get initialState => WatchlistLoading();

  @override
  Stream<WatchlistState> mapEventToState(BasicWatchlistEvent event) async* {
    repository = WatchlistRepository();
    if (event is AddToWatchlist) {
      yield* _mapAddToWatchlist(event.watchlist);
    } else if (event is FetchWatchlistByUser) {
      yield* _mapFetchWatchlistByUserId(event.page, event.userId);
    } else if (event is DeleteFromWatchlist) {
      yield* _mapDeleteWatchlistElement(event.watchlist);
    } else if (event is CheckIfMovieIsInUserWatchlist){
      yield* _mapCheckIfMovieIsInUserWatchlist(event.userId,event.movieId);
    } else if (event is RatingBlocReturnToInitialState) {
      yield initialState;
    }
  }

  Stream<WatchlistState> _mapAddToWatchlist(WatchlistModel watchlist) async* {
    try {
      final ratingsPostSuccess =
          await this.repository.postNewWatchlistElement(watchlist);
      if (ratingsPostSuccess) {
        yield WatchlistPublished();
      } else {
        yield WatchlistNotPublished();
      }
    } catch (_) {
      yield WatchlistNotPublished();
    }
  }

  Stream<WatchlistState> _mapDeleteWatchlistElement(
      WatchlistModel watchlist) async* {
    try {
      final watchlistDeletionSuccess =
          await this.repository.deleteWatchlist(watchlist);
      if (watchlistDeletionSuccess) {
        yield WatchlistPublished();
      } else {
        yield WatchlistNotPublished();
      }
    } catch (_) {
      yield WatchlistNotPublished();
    }
  }

  Stream<WatchlistState> _mapFetchWatchlistByUserId(
      int page, int userId) async* {
    try {
      final movieWatchlist = await this.repository.fetchMovieWatchlistByUserId(page, userId, );
      yield MovieWatchlistLoaded(movieWatchlist);
    } catch (_) {
      yield WatchlistNotLoaded();
    }
  }

  Stream<WatchlistState> _mapCheckIfMovieIsInUserWatchlist(
      int userId, int movieId) async* {
    try {
      final movieIsInWatchlist =
          await this.repository.checkIfMovieIsInUserWatchlist(userId, movieId);
      if (movieIsInWatchlist) {
        yield WatchlistExists();
      } else {
        yield WatchlistDoesNotExists();
      }
    } catch (_) {
      yield WatchlistNotLoaded();
    }
  }
}
