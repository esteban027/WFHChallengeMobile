class WatchlistPageModel {
  int _page;
  int _totalPages;
  int _totalItems;
  int _itemsPerPage;
  bool _hasNext;
  bool _hasPrev;
  List<WatchlistModel> _items = [];

  WatchlistPageModel.fromJson(Map<String, dynamic> parsedJson) {
    _page = parsedJson['page'];
    _totalPages = parsedJson['total_pages'];
    _totalItems = parsedJson['total_items'];
    _itemsPerPage = parsedJson['items_per_page'];
    _hasNext = parsedJson['has_next'];
    _hasPrev = parsedJson['has_prev'];
    List<WatchlistModel> temp = [];
    for (int i = 0; i < parsedJson['items'].length; i++) {
      WatchlistModel watchlistModel = WatchlistModel(parsedJson['items'][i]);
      temp.add(watchlistModel);
    }
    _items = temp;
  }
  int get page => _page;

  int get totalPages => _totalPages;

  int get totalItems => _totalItems;

  int get itemsPerPage => _itemsPerPage;

  bool get hasNext => _hasNext;

  bool get hasPrev => _hasNext;

  List<WatchlistModel> get items => _items;
}

class WatchlistModel {
  int _user;
  int _movie;
  int _timestamp;

  WatchlistModel(watchlistModel) {
    _user = watchlistModel['user'];
    _movie = watchlistModel['movie'];
    _timestamp = watchlistModel['timestamp'];
  }

  WatchlistModel.buildLocal(this._user,this._movie,this._timestamp);

  WatchlistModel.fromJson(Map<String, dynamic> parsedJson) {
    _user = parsedJson['user'];
    _movie = parsedJson['movie'];
    _timestamp = parsedJson['timestamp'];
  }

  Map toJson() => {
    "user" : this._user,
    "movie" : this._movie,
    "timestamp" : this.timestamp
  };

  int get user => _user;

  int get movie => _movie;

  int get timestamp => _timestamp;


}

