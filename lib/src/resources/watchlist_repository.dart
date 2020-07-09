import 'dart:async';
import 'package:WFHchallenge/src/models/page_model.dart';
import 'package:http/http.dart';

import 'network.dart';
import '../models/watchlist_page_model.dart';
import '../models/network_models.dart';

class WatchlistRepository {
  final network = Network();

  Future<MoviesPageModel> fetchMovieWatchlistByUserId(int page, int userId) {
     List<Parameter> parameters = [
      Parameter(ParamaterType.page, page.toString()),
      Parameter(ParamaterType.limit, '50'),
      Parameter.forFilter(FilterType.exact, 'user', userId.toString()),
    ];
    return network.fetchWatchlistByUser(parameters);
  }

  Future<bool> postNewWatchlistElement(WatchlistModel watchlist) {
    return network.postNewWatchlistElement(watchlist);
  }

  Future<bool> deleteWatchlist(WatchlistModel watchlistModel) {
    return network.deleteWatchlistElement(watchlistModel);
  }

  Future<bool> checkIfMovieIsInUserWatchlist(int userId, int movieId) {
    return network.checkIfMovieIsInUserWatchlist(userId, movieId);
  }
}
