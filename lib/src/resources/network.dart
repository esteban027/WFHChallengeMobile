import 'dart:async';
import 'package:WFHchallenge/src/models/review_page_model.dart';
import 'package:WFHchallenge/src/models/user_model.dart';
import 'package:WFHchallenge/src/models/watchlist_page_model.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../models/page_model.dart';
import '../models/network_models.dart';
import '../models/sections_page_model.dart';
import '../models/ratings_page_model.dart';
import '../models/user_model.dart';
import '../models/user_page_model.dart';

class Network {
  Client client = Client();
  String _url = 'wfh-movies.herokuapp.com';
  String _movieEndpoint = 'movie';
  String _genresSectionsEndpoint = 'genre';
  String _ratingEndpoint = 'rating';
  String _userEndpoint = 'user';
  String _homeSectionsEndpoint = 'section';
  String _recommendationsEndpoint = 'recommendation';
  String _watchlistEndpoint = 'watchlist';
  String _reviewEndpoint = 'review';

  Map<String, String> postHeader = {
    'API_KEY':
        'y1N478S5GfjcSlaiyUp7oaztpRNUii7lhwl7cvbNinIjPu2AWzRf7T9qH7dFuPcC',
    'Content-Type': 'application/json; charset=UTF-8'
  };

  Map<String, String> getHeader = {
    'API_KEY':
        'y1N478S5GfjcSlaiyUp7oaztpRNUii7lhwl7cvbNinIjPu2AWzRf7T9qH7dFuPcC'
  };

  Future<MoviesPageModel> fetchMovies(List<Parameter> headers,
      [List<Parameter> parameterList]) async {
    Uri uri = Uri.http(_url, _movieEndpoint);

    if (parameterList != null) {
      uri = uri.replace(queryParameters: convert(parameterList));
    }

    Response response = await get(uri, headers: convert(headers));

    if (response.statusCode == 200) {
      MoviesPageModel items =
          MoviesPageModel.fromJson(json.decode(response.body));
      return items;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<MoviesPageModel> fetchRecommendations(
      int id, bool fecthFromUser, List<Parameter> headers,
      [List<Parameter> parameterList]) async {
    var path;
    if (fecthFromUser) {
      path =
          _recommendationsEndpoint + '/' + _userEndpoint + '/' + id.toString();
    } else {
      path =
          _recommendationsEndpoint + '/' + _movieEndpoint + '/' + id.toString();
    }
    Uri uri = Uri.http(_url, path);

    if (parameterList != null) {
      uri = uri.replace(queryParameters: convert(parameterList));
    }

    Response response = await get(uri, headers: convert(headers));

    if (response.statusCode == 200) {
      MoviesPageModel items =
          MoviesPageModel.fromJson(json.decode(response.body));
      return items;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<SectionsPageModel> fetchGenresSections(
      [List<Parameter> parameterList]) async {
    Uri uri = Uri.http(_url, _genresSectionsEndpoint);

    if (parameterList != null) {
      uri = uri.replace(queryParameters: convert(parameterList));
    }

    Response response = await get(uri, headers: getHeader);

    if (response.statusCode == 200) {
      SectionsPageModel items =
          SectionsPageModel.fromJson(json.decode(response.body));
      return items;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<SectionsPageModel> fetchHomeSections(
      [List<Parameter> parameterList]) async {
    Uri uri = Uri.http(_url, _homeSectionsEndpoint);

    if (parameterList != null) {
      uri = uri.replace(queryParameters: convert(parameterList));
    }

    Response response = await get(uri, headers: getHeader);

    if (response.statusCode == 200) {
      SectionsPageModel items =
          SectionsPageModel.fromJson(json.decode(response.body));
      return items;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<RatingsPageModel> fetchRatings([List<Parameter> parameterList]) async {
    Uri uri = Uri.http(_url, _ratingEndpoint);

    if (parameterList != null) {
      uri = uri.replace(queryParameters: convert(parameterList));
    }

    Response response = await get(uri, headers: getHeader);
    if (response.statusCode == 200) {
      RatingsPageModel items =
          RatingsPageModel.fromJson(json.decode(response.body));
      return items;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<RatingModel> fetchUserRatingByMovie(String userMovie) async {
    Uri uri = Uri.http(_url, _ratingEndpoint + '/' + userMovie);

    Response response = await get(uri, headers: getHeader);
    if (response.statusCode == 200) {
      RatingModel rating = RatingModel.fromJson(json.decode(response.body));
      return rating;
    } else {
      throw Exception(response.statusCode);
    }
  }

  convert(List<Parameter> parameters) {
    Map<String, String> convertedParameters = {};
    for (int i = 0; i < parameters.length; i++) {
      convertedParameters[parameters[i].type.name] = parameters[i].value;
    }
    return convertedParameters;
  }

  Future<bool> postNewRating(RatingModel rating) async {
    Uri uri = Uri.http(_url, _ratingEndpoint);

    var request = post(uri, body: jsonEncode(rating), headers: postHeader);
    Response response = await request;
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateRating(RatingModel rating) async {
    var completeRatingEndpoint = _ratingEndpoint +
        '/' +
        rating.movieId.toString() +
        '_' +
        rating.user.toString();
    Uri uri = Uri.http(_url, completeRatingEndpoint);

    var request = put(uri, body: jsonEncode(rating), headers: postHeader);
    Response response = await request;
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<UserModel> postUser(UserModel user) async {
    Uri uri = Uri.http(_url, _userEndpoint);

    var request = post(uri, body: jsonEncode(user), headers: postHeader);

    Response response = await request;
    if (response.statusCode == 200) {
      UserModel user = UserModel.fromJson(json.decode(response.body));
      return user;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<UserModel> getUser(List<Parameter> parameterList) async {
    Uri uri = Uri.http(_url, _userEndpoint);

    uri = uri.replace(queryParameters: convert(parameterList));

    Response response = await get(uri, headers: getHeader);
    if (response.statusCode == 200) {
      UserPageModel userPage =
          UserPageModel.fromJson(json.decode(response.body));
      return userPage.items.first;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<List<GraphicRating>> getGraphicRatingByMovie(int movieId) async {
    Uri uri =
        Uri.http(_url, _ratingEndpoint + '/rolling-avg/' + movieId.toString());

    List<GraphicRating> ratingsConverted = [];

    Response response = await get(uri, headers: getHeader);
    if (response.statusCode == 200) {
      Map<String, dynamic> ratings = jsonDecode(response.body);
      print(ratings);
      ratings.forEach((key, value) {
        var rating = GraphicRating(int.parse(key), value);
        ratingsConverted.add(rating);
      });
      return ratingsConverted;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<bool> postNewWatchlistElement(WatchlistModel watchlist) async {
    Uri uri = Uri.http(_url, _watchlistEndpoint);

    var request = post(uri, body: jsonEncode(watchlist), headers: postHeader);
    Response response = await request;
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<MoviesPageModel> fetchWatchlistByUser(
      [List<Parameter> parameterList]) async {
    Uri uri = Uri.http(_url, _watchlistEndpoint);

    if (parameterList != null) {
      uri = uri.replace(queryParameters: convert(parameterList));
    }

    Response response = await get(uri, headers: getHeader);
    if (response.statusCode == 200) {
      WatchlistPageModel watchlist =
          WatchlistPageModel.fromJson(json.decode(response.body));
      return await fetchMoviesFromWatchlist(watchlist);
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<MoviesPageModel> fetchMoviesFromWatchlist(
      WatchlistPageModel watchlist) async {
    Uri uri = Uri.http(_url, _movieEndpoint);
    List<String> movieIds = [];
    watchlist.items.forEach((watchlist) {
      movieIds.add(' ' + watchlist.movie.toString() + ' ');
    });

    List<Parameter> parameterList = [
      Parameter(ParamaterType.page, '1'),
      Parameter(ParamaterType.limit, '1000'),
      Parameter.forListFilter('id', movieIds, FilterType.anyOf)
    ];

    uri = uri.replace(queryParameters: convert(parameterList));

    Response response = await get(uri, headers: getHeader);
    if (response.statusCode == 200) {
      MoviesPageModel moviePageModel =
          MoviesPageModel.fromJson(json.decode(response.body));
      return moviePageModel;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<bool> deleteWatchlistElement(WatchlistModel watchlist) async {
    Uri uri = Uri.http(
        _url,
        _watchlistEndpoint +
            '/' +
            watchlist.movie.toString() +
            '_' +
            watchlist.user.toString());

    var request = delete(uri, headers: postHeader);
    Response response = await request;
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkIfMovieIsInUserWatchlist(int userId, int movieId) async {
    Uri uri = Uri.http(
        _url,
        _watchlistEndpoint +
            '/' +
            movieId.toString() +
            '_' +
            userId.toString());

    var request = get(uri, headers: getHeader);
    Response response = await request;
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<ReviewsPageModel> fetchReviews(List<Parameter> parameterList) async {
    Uri uri = Uri.http(_url, _reviewEndpoint);
    uri = uri.replace(queryParameters: convert(parameterList));

    var request = get(uri, headers: getHeader);
    Response response = await request;
    if (response.statusCode == 200) {
      ReviewsPageModel reviewsPageModel =
          ReviewsPageModel.fromJson(json.decode(response.body));
      return reviewsPageModel;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<bool> postNewReview(ReviewModelThin review) async {
    Uri uri = Uri.http(_url, _reviewEndpoint);

    var request = post(uri, body: jsonEncode(review), headers: postHeader);
    Response response = await request;
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
