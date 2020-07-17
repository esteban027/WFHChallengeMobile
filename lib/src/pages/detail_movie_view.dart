import 'package:WFHchallenge/src/Events/movies_events.dart';
import 'package:WFHchallenge/src/Events/ratings_events.dart';
import 'package:WFHchallenge/src/Events/reviews_events.dart';
import 'package:WFHchallenge/src/Events/watchlist_events.dart';
import 'package:WFHchallenge/src/States/movies_states.dart';
import 'package:WFHchallenge/src/States/ratings_states.dart';
import 'package:WFHchallenge/src/States/reviews_states.dart';
import 'package:WFHchallenge/src/States/watchlist_states.dart';
import 'package:WFHchallenge/src/blocs/movies_bloc.dart';
import 'package:WFHchallenge/src/blocs/reviews_bloc.dart';
import 'package:WFHchallenge/src/blocs/user_rating_bloc.dart';
import 'package:WFHchallenge/src/blocs/ratings_bloc.dart';
import 'package:WFHchallenge/src/blocs/watchlist_bloc.dart';
import 'package:WFHchallenge/src/models/page_model.dart';
import 'package:WFHchallenge/src/models/ratings_page_model.dart';
import 'package:WFHchallenge/src/models/review_page_model.dart';
import 'package:WFHchallenge/src/models/user_model.dart';
import 'package:WFHchallenge/src/models/watchlist_page_model.dart';
import 'package:WFHchallenge/src/pages/reviews_listst_view.dart';
import 'package:WFHchallenge/src/resources/sign_in_repository.dart';
import 'package:WFHchallenge/src/widgets/chart.dart';
import 'package:WFHchallenge/src/widgets/moviePoster.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class DetailMovieView extends StatefulWidget {
  DetailMovieView({Key key, @required this.movie, @required this.userId})
      : super(key: key);

  final MovieModel movie;
  final int userId;

  @override
  _DetailMovieViewState createState() => _DetailMovieViewState();
}

class _DetailMovieViewState extends State<DetailMovieView> {
  final double heigthMovie = 309;
  final double widthMovie = 99;
  final Color _darkBlue = Color.fromRGBO(22, 25, 29, 1);
  final Color _blue = Color.fromRGBO(28, 31, 44, 1);
  final Color _orange = Color.fromRGBO(235, 89, 25, 1);
  final Color _blueContainer = Color.fromRGBO(40, 65, 109, 0.10);
  Color _buttonColor = Colors.grey;
  int dateas = (DateTime.now().millisecondsSinceEpoch);
  double buttonSected = 0;
  bool isfirstLaunch = true;
  String comment;
  bool alreadyReviewed = false;

  List<Color> starsColor = [
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey
  ];

  Map<int, bool> starState = {0: false, 1: false, 2: false, 3: false, 4: false};

  final graphRatingBloc = LoadRatingsBloc();
  final postRatingBloc = UserRatingBloc();
  final moviesBloc = LoadMoviesBloc();
  final watchListBloc = WatchlistBloc();
  final reviewsBloc = LoadReviewsBloc();

  bool publishedWatchlist = false;
  UserModel userModel;
  List<ReviewModel> reviews = [];

  TextEditingController reviewController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    postRatingBloc.add(RatingBlocReturnToInitialState());
    graphRatingBloc.add(FetchRatingsByMovieId(widget.movie.id));
    moviesBloc.add(FetchMoviesRecommendationFromMovie(widget.movie.id));
    watchListBloc.add(CheckIfMovieIsInUserWatchlist(
        widget.userId == null ? 1 : widget.userId, widget.movie.id));
  }

  void getuser() async {
    final signInRepository =
        Provider.of<SignInRepository>(context, listen: false);
    userModel = await signInRepository.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    final double widthContainer = MediaQuery.of(context).size.width - 80;
    getuser();
    List<String> genres = widget.movie.genre.split('|');
    reviewsBloc.add(FetchReviewsByMovieId(widget.movie.id));
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            child: _imageAndRating(context),
          ),
          Row(
            children: <Widget>[
              Spacer(),
              Container(
                child: Column(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () async {
                        postRatingBloc.add(FetchRatingByUserIdAndMovieId(
                            widget.userId, widget.movie.id));
                        bottomSheet();
                      },
                      child: Image.asset(
                        'assets/Star.png',
                        color: Colors.white,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      'Rate it',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () async {
                        postRatingBloc.add(FetchRatingByUserIdAndMovieId(
                            widget.userId, widget.movie.id));
                        commentsSheet();
                      },
                      child: Image.asset(
                        'assets/review.png',
                        color: Colors.white,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      'Add Review',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    )
                  ],
                ),
              ),
              BlocBuilder(
                  bloc: watchListBloc,
                  builder: (BuildContext context, state) {
                    // print(state);
                    if (state is WatchlistExists) {
                      return _addToWachtList(true);
                    } else if (state is WatchlistDoesNotExists) {
                      return _addToWachtList(false);
                    } else if (state is WatchlistPublished) {
                      return _addToWachtList(publishedWatchlist);
                    }
                    // else if (state is WatchlistNotPublished) {
                    //   return _addToWachtList(false);
                    // }
                    return Center(child: CircularProgressIndicator());
                  }),
              Spacer(),
            ],
          ),
          Container(
            color: _blueContainer,
            margin: EdgeInsets.only(right: 20, left: 20, top: 10),
            child: Column(
              children: <Widget>[
                // TITLE
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Text(
                      widget.movie.title,
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                    ),
                  ),
                  color: _darkBlue,
                  width: MediaQuery.of(context).size.width - 40,
                ),

                // MOVIE INFO

                Center(
                  child: Container(
                    color: _darkBlue,
                    width: widthContainer,
                    height: 85,
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: <Widget>[
                        _movieInfo(),
                        Spacer(),
                        _genres(genres),
                      ],
                    ),
                  ),
                ),

                // Description

                Center(
                  child: Container(
                    child: Text(
                      widget.movie.description,
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                    width: widthContainer,
                    height: 90,
                    margin: EdgeInsets.only(top: 11, bottom: 10),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: _blueContainer,
            margin: EdgeInsets.only(right: 20, left: 20, top: 20),
            child: Column(
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Text(
                      'Movie Score',
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  color: _darkBlue,
                  width: MediaQuery.of(context).size.width - 40,
                  height: 52,
                  // margin: EdgeInsets.only(top: 11),
                ),
                BlocBuilder(
                    bloc: graphRatingBloc,
                    builder: (BuildContext context, state) {
                      if (state is GraphicRatingsLoaded) {
                        return LineChartSample1(state.ratingList);
                      } else if (state is RatingsLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return Center(child: CircularProgressIndicator());
                    }),
              ],
            ),
          ),

          Container(
            color: _blueContainer,
            margin: EdgeInsets.only(right: 20, left: 20, top: 20),
            child: Column(
              children: <Widget>[
                // REVIEWS
                BlocBuilder(
                    bloc: reviewsBloc,
                    builder: (BuildContext context, state) {
                      // print(state);
                      if (state is ReviewsLoaded) {
                        reviews = state.reviewsPage.items;
                        return _reviewsSection(state.reviewsPage.items);
                      } else if (state is ReviewsNotLoaded) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return Center(child: CircularProgressIndicator());
                    }),
              ],
            ),
          ),

          // MOVIES YOU SHOULD WATCH

          Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Text(
                      'Movies like this you should watch',
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  color: _darkBlue,
                  width: MediaQuery.of(context).size.width - 40,
                  height: 52,
                ),
                BlocBuilder(
                    bloc: moviesBloc,
                    builder: (BuildContext context, state) {
                      if (state is MoviesLoaded) {
                        return _moviesRecomendation(state.moviesPage.items);
                      } else if (state is MoviesLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return Center(child: CircularProgressIndicator());
                    }),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: _blue,
    );
  }

  Widget _reviewsSection(List<ReviewModel> reviews) {
    var numberOfReviews = reviews.length;
    List<Widget> reviewsCells = [];

    if (numberOfReviews >= 4) {
      for (int i = 0; i < 4; i++) {
        if (reviews[i].user == userModel.id) {
          alreadyReviewed = true;
        }
        reviewsCells.add(_commentsRow(reviews[i]));
      }
    } else if (numberOfReviews != 0) {
      reviews.forEach((review) {
        if (review.user == userModel.id) {
          alreadyReviewed = true;
        }
        reviewsCells.add(_commentsRow(review));
      });
    }

    return Column(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Reviews ($numberOfReviews user reviews)',
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                  textAlign: TextAlign.left,
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.navigate_next,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReviewListView(
                                reviews: reviews,
                              )));
                },
              ),
            ],
          ),
          color: _darkBlue,
          width: MediaQuery.of(context).size.width - 40,
          height: 52,
        ),
        reviewsCells.length != 0
            ? Column(
                children: reviewsCells,
              )
            : Divider()
      ],
    );

    // _reviews(),
  }

  Widget _commentsRow(ReviewModel review) {
    var date = new DateTime.fromMillisecondsSinceEpoch(review.timestamp * 1000);
    final DateFormat formatter = DateFormat('LLLL dd,yyyy');
    final String formatted = formatter.format(date);

    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(review.rating.userModel.name,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  )),
              Container(
                child: Row(
                  children: <Widget>[
                    Text(review.rating.rating.toString(),
                        style: TextStyle(
                          fontSize: 11,
                          color: _orange,
                        )),
                    Container(
                      child: Image.asset(
                        'assets/Star.png',
                        color: _orange,
                        fit: BoxFit.fill,
                      ),
                      width: 10,
                      height: 10,
                    )
                  ],
                ),
                margin: EdgeInsets.only(left: 10),
              ),
              Spacer(),
              Text(formatted,
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  )),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                child: Text(
                  review.comment,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
                margin: EdgeInsets.only(top: 10),
              ),
              Spacer()
            ],
          ),
          Divider(
            color: Color.fromRGBO(40, 65, 109, 1),
            height: 20,
          )
        ],
      ),
      margin: EdgeInsets.all(15),
    );
  }

  Widget _addToWachtList(bool isOnWachtList) {
    return Container(
      child: Column(
        children: <Widget>[
          FlatButton(
              onPressed: () {
                var timeStapFromatted =
                    ((DateTime.now().millisecondsSinceEpoch) / 1000).round();
                var watchlist = WatchlistModel.buildLocal(
                    widget.userId, widget.movie.id, timeStapFromatted);
                if (isOnWachtList) {
                  areYouSureBottomSheet();
                } else {
                  setState(() {
                    publishedWatchlist = true;
                    watchListBloc.add(AddToWatchlist(watchlist));
                  });
                }
              },
              child: isOnWachtList
                  ? SvgPicture.asset(
                      'assets/Icons/Checkcheck.svg',
                      color: Colors.white,
                    )
                  : Image.asset(
                      'assets/Add.png',
                      color: Colors.white,
                      fit: BoxFit.fill,
                    )),
          Text(
            isOnWachtList ? 'Watchlist' : 'Add to watchlist',
            style: TextStyle(fontSize: 10, color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget _moviesRecomendation(List<MovieModel> movies) {
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: MoviePoster(
              movie: movies[index],
              user: widget.userId,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailMovieView(
                            movie: movies[index],
                            userId: widget.userId,
                          )));
            },
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      margin: EdgeInsets.only(top: 20),
    );
  }

  Widget _ratingWidget() {
    return Container(
      child: Row(
        children: <Widget>[
          Spacer(),
          Text(
            widget.movie.rating.toStringAsFixed(1),
            style: TextStyle(color: _blue, fontSize: 15),
          ),
          Container(
            child: Image.asset('assets/Star.png', color: _blue),
            width: 12.8,
            height: 12.8,
            padding: EdgeInsets.only(left: 1),
          ),
          Spacer(),
          Column(
            children: <Widget>[
              Spacer(),
              Text(
                widget.movie.voteCount.toString(),
                style: TextStyle(color: _blue, fontSize: 11),
              ),
              Text(
                'Ratings',
                style: TextStyle(color: _blue, fontSize: 11),
              ),
              Spacer(),
            ],
          ),
          Spacer(),
        ],
      ),
      width: 124,
      height: 47,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
          color: Colors.white),
    );
  }

  Widget _imageAndRating(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          child: FadeInImage(
            placeholder: AssetImage('assets/defaultcover.png'),
            image: NetworkImage(widget.movie.posterPath),
            height: 309,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 309,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.transparent, _blue],
            stops: [0.0, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
        ),
        Positioned(bottom: 18, right: 0, child: _ratingWidget()),
        Positioned(
          top: 30,
          left: 0,
          child: FlatButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
      ],
      fit: StackFit.passthrough,
    );
  }

  Widget _movieInfo() {
    return Container(
      child: Column(
        children: _movieInfoRows(),
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      margin: EdgeInsets.only(left: 10),
    );
  }

  Widget _genres(List<String> genresStrings) {
    List<Widget> genresColumn = [];
    List<Widget> genresRow = [];

    genresStrings.forEach((genreTitle) {
      genresRow.add(
        Container(
          child: Center(
              child: Text(
            genreTitle,
            style: TextStyle(color: Colors.white, fontSize: 11),
          )),
          width: 68,
          height: 17,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: _orange, borderRadius: BorderRadius.circular(14)),
        ),
      );
    });
    if (genresRow.length > 1) {
      for (var i = 0; i < genresRow.length; i += 2) {
        if (genresRow.length == i + 1) {
          genresColumn.add(genresRow[i]);
        } else {
          genresColumn.add(Row(
            children: <Widget>[genresRow[i], genresRow[i + 1]],
            mainAxisAlignment: MainAxisAlignment.center,
          ));
        }
      }
    } else {
      genresColumn.add(genresRow[0]);
    }

    return Container(
      child: Column(
        children: genresColumn,
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      margin: EdgeInsets.only(right: 15),
    );
  }

  List<Widget> _movieInfoRows() {
    String date = widget.movie.releaseDate == null
        ? 'No date'
        : DateTime.parse(widget.movie.releaseDate).year.toString();
    return [
      Container(
        child: Row(
          children: <Widget>[
            Text(
              'Release: ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              date,
              style: TextStyle(color: Colors.white, fontSize: 11),
            ),
          ],
        ),
        width: 100,
      ),
    ];
  }

  Widget numberAndStart(int number, StateSetter setStateSheet) {
    return Container(
      child: FlatButton(
          onPressed: () {
            setStateSheet(() {
              for (int i = 0; i < starState.length; i++) {
                starState[i] = i < number;
              }
              buttonSected = number.toDouble();
              _buttonColor = _orange;
              paintStarts();
            });
          },
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  number.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                margin: EdgeInsets.only(bottom: 15),
              ),
              Image.asset(
                'assets/Star.png',
                color: starsColor[number - 1],
                width: 22,
                height: 22,
              ),
            ],
          )),
      width: 50,
    );
  }

  void bottomSheet() {
    showModalBottomSheet(
        useRootNavigator: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, setStateModal) {
            return BlocBuilder(
                bloc: postRatingBloc,
                builder: (BuildContext context, state) {
                  if (state is SingleRatingLoaded) {
                    return alert(setStateModal, state.rating);
                  } else if (state is RatingsNotLoaded) {
                    return alert(setStateModal, null);
                  } else if (state is RatingPublished ||
                      state is RatingNotPublished) {
                    postRatingBloc.add(RatingBlocReturnToInitialState());
                    Navigator.pop(context);
                  }
                  return Container(
                    child: Center(child: CircularProgressIndicator()),
                    height: MediaQuery.of(context).size.height * 0.3,
                    color: _darkBlue,
                  );
                });
          });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));
  }

  Widget alert(StateSetter setStateModal2, RatingModel ratingModel) {
    var timeStapFromatted = (dateas / 1000).round();

    if (ratingModel != null && isfirstLaunch) {
      for (int i = 0; i < starState.length; i++) {
        starState[i] = i < ratingModel.rating.round();
      }
      isfirstLaunch = !isfirstLaunch;
      paintStarts();
    }

    return Container(
      color: Colors.transparent,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  Text('Rate this movie here',
                      style: TextStyle(color: Colors.white, fontSize: 13)),
                ],
              ),
            ),
            Divider(
              height: 5,
              color: Colors.white,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Spacer(),
                        numberAndStart(1, setStateModal2),
                        Spacer(),
                        numberAndStart(2, setStateModal2),
                        Spacer(),
                        numberAndStart(3, setStateModal2),
                        Spacer(),
                        numberAndStart(4, setStateModal2),
                        Spacer(),
                        numberAndStart(5, setStateModal2),
                        Spacer(),
                      ],
                    ),
                    padding: EdgeInsets.only(top: 31, bottom: 43),
                  ),
                ],
              ),
            ),
            Container(
              child: FlatButton(
                onPressed: () {
                  if (ratingModel != null) {
                    postRatingBloc.add(UpdateRating(
                        RatingModel.createNewRatingInit(widget.userId,
                            widget.movie.id, buttonSected, timeStapFromatted)));
                  } else {
                    postRatingBloc.add(PublishNewRating(
                        RatingModel.createNewRatingInit(widget.userId,
                            widget.movie.id, buttonSected, timeStapFromatted)));
                  }
                },
                child: Text(
                  'Rate It',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                  color: _buttonColor,
                  borderRadius: BorderRadius.circular(108)),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: _blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
      ),
    );
  }

  void clearStates([int rating = 0]) {
    starState[0] = false;
    starState[1] = false;
    starState[2] = false;
    starState[3] = false;
    starState[4] = false;

    if (rating != 0) {
      for (var i = 0; i < rating; i++) {
        starState[i] = true;
      }
    }
    paintStarts();
  }

  void paintStarts() {
    bool state = false;
    starsColor[0] = starState[0] ? _orange : Colors.grey;
    starsColor[1] = starState[1] ? _orange : Colors.grey;
    starsColor[2] = starState[2] ? _orange : Colors.grey;
    starsColor[3] = starState[3] ? _orange : Colors.grey;
    starsColor[4] = starState[4] ? _orange : Colors.grey;

    starsColor.forEach((star) {
      if (star == _orange) {
        state = true;
      }
    });

    _buttonColor = state ? _orange : Colors.grey;
  }

  void areYouSureBottomSheet() {
    var movieName = widget.movie.title;
    var timeStapFromatted =
        ((DateTime.now().millisecondsSinceEpoch) / 1000).round();
    var watchlist = WatchlistModel.buildLocal(
        widget.userId, widget.movie.id, timeStapFromatted);

    showModalBottomSheet(
        useRootNavigator: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, setStateModal) {
            return Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      'Are you sure that you want to remove $movieName from your Watchlist?',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 32),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                  Divider(
                    height: 5,
                    color: Colors.white,
                  ),
                  Container(
                    child: FlatButton(
                      onPressed: () {
                        watchListBloc.add(DeleteFromWatchlist(watchlist));
                        publishedWatchlist = false;
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Remove from my Watchlist',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                        color: _orange,
                        borderRadius: BorderRadius.circular(108)),
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: _blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              height: MediaQuery.of(context).size.height * 0.3,
            );
          });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));
  }

  Widget alerComments(StateSetter setStateModal3, RatingModel ratingModel,
      BuildContext alertContext) {
    var timeStapFromatted = (dateas / 1000).round();

    if (ratingModel != null && isfirstLaunch) {
      for (int i = 0; i < starState.length; i++) {
        starState[i] = i < ratingModel.rating.round();
      }
      isfirstLaunch = !isfirstLaunch;
      paintStarts();
    }

    return Container(
      color: Colors.transparent,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  Text('Add a Review',
                      style: TextStyle(color: Colors.white, fontSize: 13)),
                ],
              ),
            ),
            Divider(
              height: 5,
              color: Colors.white,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Spacer(),
                        numberAndStart(1, setStateModal3),
                        Spacer(),
                        numberAndStart(2, setStateModal3),
                        Spacer(),
                        numberAndStart(3, setStateModal3),
                        Spacer(),
                        numberAndStart(4, setStateModal3),
                        Spacer(),
                        numberAndStart(5, setStateModal3),
                        Spacer(),
                      ],
                    ),
                    padding: EdgeInsets.only(top: 31, bottom: 43),
                  ),
                ],
              ),
            ),
            Container(
              child: TextField(
                maxLines: 4,
                decoration: InputDecoration.collapsed(
                  hintText: alreadyReviewed
                      ? "Movie already reviewed "
                      : "Add a review of this movie",
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 11,
                  ),
                ),
                cursorColor: _orange,
                controller: reviewController,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                ),
                enabled: !alreadyReviewed,
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.15,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(width: 1, color: Colors.white)),
            ),
            Container(
              child: FlatButton(
                onPressed: alreadyReviewed
                    ? null
                    : () {
                        if (ratingModel == null) {
                          ratingModel = RatingModel.createNewRatingInit(
                              widget.userId,
                              widget.movie.id,
                              buttonSected,
                              timeStapFromatted);
                        }

                        var review = ReviewModelThin.createNewReviewInit(
                            widget.userId,
                            widget.movie.id,
                            reviewController.text,
                            timeStapFromatted,
                            ratingModel.rating);
                        reviewsBloc.add(PublishNewReview(review));

                        Navigator.pop(alertContext);
                      },
                child: Text(
                  'Rate It',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.only(top: 26),
              decoration: BoxDecoration(
                  color: alreadyReviewed ? Colors.grey : _buttonColor,
                  borderRadius: BorderRadius.circular(108)),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: _blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
      ),
    );
  }

  void commentsSheet() {
    var timeStapFromatted = (dateas / 1000).round();

    showModalBottomSheet(
        useRootNavigator: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext contextAlert, setStateModal) {
            return BlocBuilder(
                bloc: postRatingBloc,
                builder: (BuildContext context, state) {
                  if (state is SingleRatingLoaded) {
                    return alerComments(
                        setStateModal, state.rating, contextAlert);
                  } else if (state is RatingsNotLoaded) {
                    return alerComments(setStateModal, null, contextAlert);
                  } else if (state is RatingPublished) {
                    postRatingBloc.add(RatingBlocReturnToInitialState());

                    Navigator.pop(context);
                  }
                  return Container(
                    child: Center(child: CircularProgressIndicator()),
                    height: MediaQuery.of(context).size.height * 0.3,
                    color: _darkBlue,
                  );
                });
          });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));
  }
}
