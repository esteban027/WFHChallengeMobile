import 'dart:async';
import 'package:WFHchallenge/src/models/user_model.dart';
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

  Map<String, String> postHeader = {
      'API_KEY':
      'y1N478S5GfjcSlaiyUp7oaztpRNUii7lhwl7cvbNinIjPu2AWzRf7T9qH7dFuPcC',
      'Content-Type': 'application/json; charset=UTF-8'
    };

  Map<String, String> getHeader = {
    'API_KEY':
    'y1N478S5GfjcSlaiyUp7oaztpRNUii7lhwl7cvbNinIjPu2AWzRf7T9qH7dFuPcC'
  };

  Future<MoviesPageModel> fetchMovies([List<Parameter> parameterList]) async {
    Uri uri = Uri.http(_url, _movieEndpoint);

    if (parameterList != null) {
      uri = uri.replace(queryParameters: convert(parameterList));
    }

    Response response = await get(uri, headers: getHeader);

    if (response.statusCode == 200) {
      MoviesPageModel items =
          MoviesPageModel.fromJson(json.decode(response.body));
      return items;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<SectionsPageModel> fetchGenresSections([List<Parameter> parameterList]) async {
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

  Future<SectionsPageModel> fetchHomeSections([List<Parameter> parameterList]) async {
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

    Response response = await get(uri
     , headers: getHeader);
    if (response.statusCode == 200) {
      RatingsPageModel items =
          RatingsPageModel.fromJson(json.decode(response.body));
      return items;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<RatingModel> fetchUserRatingByMovie(String userMovie) async {
    Uri uri = Uri.http(_url, _ratingEndpoint+'/'+userMovie);

    Response response = await get(uri
        , headers: getHeader);
    if (response.statusCode == 200) {
      RatingModel rating =
      RatingModel.fromJson(json.decode(response.body));
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
     
    var request =   post(uri,
    body: jsonEncode(rating),
    headers: postHeader
    );
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

    Response response = await get(uri
        , headers: getHeader);
    if (response.statusCode == 200) {
      UserPageModel userPage =
      UserPageModel.fromJson(json.decode(response.body));
      return userPage.items.first;
    } else {
      throw Exception(response.statusCode);
    }
  }
}
