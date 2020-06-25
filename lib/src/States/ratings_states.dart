import 'package:flutter/foundation.dart';
import '../models/ratings_page_model.dart';

@immutable
abstract class RatingsState {}

class RatingsLoading extends RatingsState {
  @override
  String toString() => 'RatingsLoading';
}

class RatingsLoaded extends RatingsState {
  final RatingsPageModel ratingsPage;

  RatingsLoaded(this.ratingsPage);

  @override
  String toString() => 'RatingsLoaded{genres: $ratingsPage}';
}

class RatingsNotLoaded extends RatingsState {
  @override
  String toString() => 'RatingsNotLoaded';
}

class PublishingRating extends RatingsState {
  @override
  String toString() => 'Publishing Rating';
}

class RatingPublished extends RatingsState {
  @override
  String toString() => 'Rating Published';
}

class RatingNotPublished extends RatingsState {
   @override
  String toString() => 'Rating Not Published';
}

