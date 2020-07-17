class MoviesPageModel {
  int _page;
  int _totalPages;
  int _totalItems;
  int _itemsPerPage;
  bool _hasNext;
  bool _hasPrev;
  List<MovieModel> _items = [];

  MoviesPageModel.fromJson(Map<String, dynamic> parsedJson) {
    _page = parsedJson['page'];
    _totalPages = parsedJson['total_pages'];
    _totalItems = parsedJson['total_items'];
    _itemsPerPage = parsedJson['items_per_page'];
    _hasNext = parsedJson['has_next'];
    _hasPrev = parsedJson['has_prev'];
    List<MovieModel> temp = [];
    for (int i = 0; i < parsedJson['items'].length; i++) {
      MovieModel movieModel = MovieModel(parsedJson['items'][i]);
      temp.add(movieModel);
    }
    _items = temp;
  }
  int get page => _page;

  int get totalPages => _totalPages;

  int get totalItems => _totalItems;

  int get itemsPerPage => _itemsPerPage;

  bool get hasNext => _hasNext;

  bool get hasPrev => _hasNext;

  List<MovieModel> get items => _items;
}

class MovieModel {
  String _title;
  int _imdbId;
  int _tmdbId;
  String _posterPath;
  String _releaseDate;
  int _budget;
  int _id;
  String _genres;
  String _description;
  double _rating;
  int _voteCount;
  String _expectedRating;
  int _cosineSimilarity;
  bool _inWatchlist;

  MovieModel(movieModel) {
    _title = movieModel['title'];
    _imdbId = movieModel['imdb_id'];
    _tmdbId = movieModel['tmdb_id'];
    _posterPath = movieModel['poster_path'];
    _releaseDate = movieModel['release_date'];
    _budget = movieModel['budget'];
    _id = movieModel['id'];
    _genres = movieModel['genres'];
    _description = movieModel['description'];
    _rating = movieModel['rating'];
    _voteCount = movieModel['vote_count'];
    _inWatchlist = movieModel['in_watchlist'];
    try {
      _expectedRating = movieModel['expected_rating'];
    }catch(_){
      _expectedRating = null;
    }
    try {
      _cosineSimilarity = movieModel['cosine_similarity'];
    }catch(_){
      _cosineSimilarity = null;
    }
  }

  String get title => _title;

  int get imdb_id => _imdbId;

  int get tmdb_id => _tmdbId;

  String get posterPath {
    return _posterPath == null ? 'https://images.benchmarkemail.com/client1222470/image8770405.png' : _posterPath;
  }

  String get releaseDate => _releaseDate;

  int get budget => _budget;

  int get id => _id;

String get genre => _genres;

String get description => _description;

double get rating => _rating;

int get voteCount => _voteCount;

String get expectedRate => _expectedRating;

int get cosineSimilarity => _cosineSimilarity;

bool get inWatchlist => _inWatchlist;
}

