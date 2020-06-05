import 'dart:async';
import 'package:http/http.dart';
import 'dart:convert';
import '../models/page_model.dart';
import '../models/network_models.dart';
import '../models/genres_page_model.dart';

class Network {
  Client client = Client();
  String _url = 'wfh-movies.herokuapp.com';
  String _movieEndpoint = 'movie';
  String _genresEndpoint = 'genre';

  Future<MoviesPageModel> fetchMovies([List<Parameter> parameterList]) async {
    Uri uri = Uri.http(_url, _movieEndpoint);

    if (parameterList != null) {
      uri = uri.replace(queryParameters: convert(parameterList));
    }

    Response response = await get(uri, headers: {
      'API_KEY':
          'y1N478S5GfjcSlaiyUp7oaztpRNUii7lhwl7cvbNinIjPu2AWzRf7T9qH7dFuPcC'
    });
    if (response.statusCode == 200) {
      MoviesPageModel items =
          MoviesPageModel.fromJson(json.decode(response.body));
      return items;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<GenresPageModel> fetchGenres([List<Parameter> parameterList]) async {
    Uri uri = Uri.http(_url, _genresEndpoint);

    if (parameterList != null) {
      uri = uri.replace(queryParameters: convert(parameterList));
    }

    Response response = await get(uri, headers: {
      'API_KEY':
          'y1N478S5GfjcSlaiyUp7oaztpRNUii7lhwl7cvbNinIjPu2AWzRf7T9qH7dFuPcC'
    });
    if (response.statusCode == 200) {
      GenresPageModel items =
          GenresPageModel.fromJson(json.decode(response.body));
      return items;
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
}
