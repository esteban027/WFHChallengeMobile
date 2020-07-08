import 'package:WFHchallenge/src/models/page_model.dart';
import 'package:flutter/foundation.dart';
import '../models/watchlist_page_model.dart';

@immutable
abstract class WatchlistState {}

class WatchlistLoading extends WatchlistState {
  @override
  String toString() => 'WatchlistLoading';
}

class MovieWatchlistLoaded extends WatchlistState {
  final MoviesPageModel moviesWatchlist;

  MovieWatchlistLoaded(this.moviesWatchlist);

  @override
  String toString() => 'WatchlistLoaded{genres: $moviesWatchlist}';
}

class WatchlistNotLoaded extends WatchlistState {
  @override
  String toString() => 'WatchlistNotLoaded';
}

class PublishingWatchlist extends WatchlistState {
  @override
  String toString() => 'Publishing Watchlist';
}

class WatchlistPublished extends WatchlistState {
  @override
  String toString() => 'Watchlist Published';
}

class WatchlistNotPublished extends WatchlistState {
  @override
  String toString() => 'Watchlist Not Published';
}

