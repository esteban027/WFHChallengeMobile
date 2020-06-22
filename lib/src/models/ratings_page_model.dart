class RatingsPageModel {
  int _page;
  int _totalPages;
  int _totalItems;
  int _itemsPerPage;
  bool _hasNext;
  bool _hasPrev;
  List<RatingModel> _items = [];

  RatingsPageModel.fromJson(Map<String, dynamic> parsedJson) {
    _page = parsedJson['page'];
    _totalPages = parsedJson['total_pages'];
    _totalItems = parsedJson['total_items'];
    _itemsPerPage = parsedJson['items_per_page'];
    _hasNext = parsedJson['has_next'];
    _hasPrev = parsedJson['has_prev'];
    List<RatingModel> temp = [];
    for (int i = 0; i < parsedJson['items'].length; i++) {
      RatingModel ratingModel = RatingModel(parsedJson['items'][i]);
      temp.add(ratingModel);
    }
    _items = temp;
  }
  int get page => _page;

  int get totalPages => _totalPages;

  int get totalItems => _totalItems;

  int get itemsPerPage => _itemsPerPage;

  bool get hasNext => _hasNext;

  bool get hasPrev => _hasNext;

  List<RatingModel> get items => _items;
}

class RatingModel {
  int _user;
  int _movieId;
  double _rating;
  int _timestamp;

  RatingModel(ratingModel) {
    _user = ratingModel['user'];
    _movieId = ratingModel['movie'];
    _rating = ratingModel['rating'];
    _timestamp = ratingModel['timestamp'];
  }

  RatingModel.createNewRatingInit(
      this._user, this._movieId, this._rating, this._timestamp);

  Map toJson() => {
    "user" : this.user,
    "movie" : this.movieId,
    "rating" : this.rating,
    "timestamp" : this.timestamp
  };

 int get user => _user;

 int get movieId => _movieId;

 double get rating => _rating;

 int get timestamp => _timestamp;
 }
