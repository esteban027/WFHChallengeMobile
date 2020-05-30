class ItemModel {
  int _page;
  int _total_pages;
  int _total_items;
  int _items_per_page;
  bool _has_next;
  bool _has_prev;
  List<_MovieModel> _items = [];

  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    _page = parsedJson['page'];
    _total_pages = parsedJson['total_pages'];
    _total_items = parsedJson['total_items'];
    _items_per_page = parsedJson['items_per_page'];
    _has_next = parsedJson['has_next'];
    _has_prev = parsedJson['has_prev'];
    List<_MovieModel> temp = [];
    for (int i = 0; i < parsedJson['items'].length; i++) {
      _MovieModel movieModel = _MovieModel(parsedJson['items'][i]);
      temp.add(movieModel);
    }
    _items = temp;
  }
}

class _MovieModel {
  String _title;
  int _imdb_id;
  int _tmdb_id;
  String _poster_path;
  String _release_date;
  int _budget;
  int _id;
  List<Genre> _genres;

  _MovieModel(movieModel) {
    _title = movieModel['title'];
    _imdb_id = movieModel['imbd_id'];
    _tmdb_id = movieModel['tmdb_id'];
    _poster_path = movieModel['poster_path'];
    _release_date = movieModel['release_date'];
    _budget = movieModel['budget'];
    _id = movieModel['id'];
    for (int i = 0; i < movieModel['genres'].lenght; i++) {
      _genres.add(movieModel['genres'][i]);
    }
  }

  String get title => _title;

  int get imdb_id => _imdb_id;

  int get tmdb_id => _tmdb_id;

  String get poster_path => _poster_path;

  String get release_date => _release_date;

  int get budget => _budget;

  int get id => _id;

  List<Genre> get genres => _genres;
}

class Genre {
  String _genre;
  Genre(genre) {
    _genre = genre['genre'];
  }
String get genre => _genre;
}
