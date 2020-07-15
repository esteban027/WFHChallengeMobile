import 'package:flutter/foundation.dart';
import 'package:WFHchallenge/src/models/review_page_model.dart';

@immutable
abstract class ReviewsState {}

class ReviewsLoading extends ReviewsState {
  @override
  String toString() => 'ReviewsLoading';
}

class ReviewsLoaded extends ReviewsState {
  final ReviewsPageModel reviewsPage;

  ReviewsLoaded(this.reviewsPage);

  @override
  String toString() => 'ReviewsLoaded{genres: $reviewsPage}';
}

class ReviewsNotLoaded extends ReviewsState {
  @override
  String toString() => 'ReviewsNotLoaded';
}

class PublishingReview extends ReviewsState {
  @override
  String toString() => 'Publishing Review';
}

class ReviewPublished extends ReviewsState {
  @override
  String toString() => 'Review Published';
}

class ReviewNotPublished extends ReviewsState {
  @override
  String toString() => 'Review Not Published';
}
