import 'dart:async';
import 'package:http/http.dart';

import 'network.dart';
import '../models/watchlist_page_model.dart';
import '../models/network_models.dart';

class WatchlistRepository {
  final netwok = Network();

  Future<WatchlistPageModel> fetchWatchlistByUserId(int page, int userId) {
     List<Parameter> parameters = [
      Parameter(ParamaterType.page, page.toString()),
      Parameter(ParamaterType.limit, '50'),
      Parameter.forFilter(FilterType.exact, 'user', userId.toString()),
      Parameter.forSort(SortType.ascendant, 'timestamp')
    ];
    return netwok.fetchWatchlistByUser();
  }

  Future<bool> postNewWatchlistElement(WatchlistModel watchlist) {
    return netwok.postNewWatchlistElement(watchlist);
  }

  Future<bool> deleteWatchlist(WatchlistModel watchlistModel) {
    return netwok.deleteWatchlistElement(watchlistModel);
  }
}
