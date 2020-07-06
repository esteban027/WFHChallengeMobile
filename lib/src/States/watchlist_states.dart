import 'package:flutter/foundation.dart';
import '../models/watchlist_page_model.dart';

@immutable
abstract class WatchlistState {}

class WatchlistLoading extends WatchlistState {
  @override
  String toString() => 'WatchlistLoading';
}

class WatchlistLoaded extends WatchlistState {
  final WatchlistPageModel watchlist;

  WatchlistLoaded(this.watchlist);

  @override
  String toString() => 'WatchlistLoaded{genres: $watchlist}';
}

class  SingleWatchlistElementLoaded extends WatchlistState {
  final WatchlistModel watchlist;

  SingleWatchlistElementLoaded(this.watchlist);

  @override
  String toString() => 'WatchlistLoaded{genres: $watchlist}';
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

