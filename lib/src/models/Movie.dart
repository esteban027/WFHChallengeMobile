
class Movies {
  int page;
  int totalPages;
  int totalItems;
  int itemsPerPage;
  bool hasNext;
  bool hasPrev;
  List<Movie> items = List();

  Movies(
    this.page,
    this.totalPages,
    this.totalItems,
    this.itemsPerPage,
    this.hasNext,
    this.hasPrev,
    this.items,
  );

  Movies.fromJsonList( List<dynamic> jsonList) {
    if (jsonList == null) return ;

    for (var item in jsonList) {
      final movie = Movie.fromJsonMap(item);
      items.add(movie);
    }
  }

  Movies.fromJsonMap(Map<String, dynamic> json) {
    page = json['page'];
    totalPages = json['total_pages'];
    totalItems = json['total_items'];
    itemsPerPage = json['items_per_page']; 
    hasNext = json['has_next']; 
    hasPrev = json['has_prev'];
  }
}

class Movie {
  String title;
  int imdbId;
  int tmdbId;
  String posterPath;
  String releaseDate;
  int budget;
  int id;
  String genres;

  Movie({
    this.title,
    this.imdbId,
    this.tmdbId,
    this.posterPath,
    this.releaseDate,
    this.budget,
    this.id,
    this.genres,
  });

  Movie.fromJsonMap(Map<String, dynamic> json) {
    title       = json['title'];
    imdbId      = json['imdb_id'];
    tmdbId      = json['tmdb_id'];
    posterPath  = json['poster_path'];
    releaseDate = json['release_date'];
    budget      = json['budget'];
    id          = json['id'];
    genres      = json['genres'];
  }

  getPosterImage() {
    if (posterPath == null) {
      return 'https://i0.wp.com/oij.org/wp-content/uploads/2016/05/placeholder.png?ssl=1';
    } else {
      return posterPath;
    }
  }

  getTitle() {
    return title;
  }
}