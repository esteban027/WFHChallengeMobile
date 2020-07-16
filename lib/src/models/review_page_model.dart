import 'package:WFHchallenge/src/models/user_model.dart';

class ReviewsPageModel {
  int _page;
  int _totalPages;
  int _totalItems;
  int _itemsPerPage;
  bool _hasNext;
  bool _hasPrev;
  List<ReviewModel> _items = [];

  ReviewsPageModel.fromJson(Map<String, dynamic> parsedJson) {
    _page = parsedJson['page'];
    _totalPages = parsedJson['total_pages'];
    _totalItems = parsedJson['total_items'];
    _itemsPerPage = parsedJson['items_per_page'];
    _hasNext = parsedJson['has_next'];
    _hasPrev = parsedJson['has_prev'];
    List<ReviewModel> temp = [];
    for (int i = 0; i < parsedJson['items'].length; i++) {
      ReviewModel reviewModel = ReviewModel(parsedJson['items'][i]);
      temp.add(reviewModel);
    }
    _items = temp;
  }
  int get page => _page;

  int get totalPages => _totalPages;

  int get totalItems => _totalItems;

  int get itemsPerPage => _itemsPerPage;

  bool get hasNext => _hasNext;

  bool get hasPrev => _hasNext;

  List<ReviewModel> get items => _items;
}

class ReviewModel {
  int _user;
  //611
  int _movieId;
  // 33
  String _comment;
  int _timestamp;
  RatingReviewModel _rating;
  double _ratingDouble;

  ReviewModel(reviewModel) {
    _user = reviewModel['user'];
    _movieId = reviewModel['movie'];
    _comment = reviewModel['comment'];
    _timestamp = reviewModel['timestamp'];
    _rating = RatingReviewModel(reviewModel['rating']);
  }

  ReviewModel.fromJson(Map<String, dynamic> parsedJson) {
    _user = parsedJson['user'];
    _movieId = parsedJson['movie'];
    _comment = parsedJson['comment'];
    _timestamp = parsedJson['timestamp'];
    _rating = RatingReviewModel(parsedJson['rating']);
  }

  ReviewModel.createNewReviewInit(this._user, this._movieId, this._comment,
      this._timestamp, this._ratingDouble);

  Map toJson() => {
        "user": this.user,
        "movie": this.movieId,
        "comment": this._comment,
        "timestamp": this.timestamp
      };

  int get user => _user;

  int get movieId => _movieId;

  String get comment => _comment;

  int get timestamp => _timestamp;

  RatingReviewModel get rating => _rating;
}

class ReviewModelThin {
  int _user;
  int _movieId;
  String _comment;
  int _timestamp;
  double _rating;

  ReviewModelThin(reviewModel) {
    _user = reviewModel['user'];
    _movieId = reviewModel['movie'];
    _comment = reviewModel['comment'];
    _timestamp = reviewModel['timestamp'];
    _rating = reviewModel['_rating'];
  }

  ReviewModelThin.createNewReviewInit(
      this._user, this._movieId, this._comment, this._timestamp, this._rating);

  Map toJson() => {
        "user": this.user,
        "movie": this.movieId,
        "comment": this._comment,
        "timestamp": this.timestamp,
        "rating": this.rating
      };

  int get user => _user;

  int get movieId => _movieId;

  String get comment => _comment;

  int get timestamp => _timestamp;

  double get rating => _rating;
}

class RatingReviewModel {
  double _rating;
  UserModel _userModel;

  RatingReviewModel(ratingModel) {
    _rating = ratingModel['rating'];
    _userModel = UserModel(ratingModel['user_model']);
  }

  RatingReviewModel.fromJson(Map<String, dynamic> parsedJson) {
    _rating = parsedJson['rating'];
    _userModel = UserModel(parsedJson['user_model']);
  }

  double get rating => _rating;

  UserModel get userModel => _userModel;
}
