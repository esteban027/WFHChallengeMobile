class PageModel {
  int _page;
  int _totalPages;
  int _totalItems;
  int _itemsPerPage;
  bool _hasNext;
  bool _hasPrev;
  List<_MovieModel> _items = [];

  PageModel.fromJson(Map<String, dynamic> parsedJson) {
    _page = parsedJson['page'];
    _totalPages = parsedJson['total_pages'];
    _totalItems = parsedJson['total_items'];
    _itemsPerPage = parsedJson['items_per_page'];
    _hasNext = parsedJson['has_next'];
    _hasPrev = parsedJson['has_prev'];
    List<_MovieModel> temp = [];
    for (int i = 0; i < parsedJson['items'].length; i++) {
      _MovieModel movieModel = _MovieModel(parsedJson['items'][i]);
      temp.add(movieModel);
    }
    _items = temp;
  }
  List<_MovieModel> get items => _items;
}

class _MovieModel {
  String _title;
  int _imdbId;
  int _tmdbId;
  String _posterPath;
  String _releaseDate;
  int _budget;
  int _id;
  String _genre;
  int _rating;
  int _voteCount;

  _MovieModel(movieModel) {
    _title = movieModel['title'];
    _imdbId = movieModel['imdb_id'];
    _tmdbId = movieModel['tmdb_id'];
    _posterPath = movieModel['poster_path'];
    _releaseDate = movieModel['release_date'];
    _budget = movieModel['budget'];
    _id = movieModel['id'];
    _genre = movieModel['genre'];
    _rating = movieModel['rating'];
    _voteCount = movieModel['vote_count'];
  }

  String get title => _title;

  int get imdb_id => _imdbId;

  int get tmdb_id => _tmdbId;

  String get poster_path => _posterPath;

  String get release_date => _releaseDate;

  int get budget => _budget;

  int get id => _id;

String get genre => _genre;

int get rating => _rating;

int get voteCount => _voteCount;
}

