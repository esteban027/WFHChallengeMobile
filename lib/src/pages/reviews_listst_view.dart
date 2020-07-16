import 'package:WFHchallenge/src/models/review_page_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewListView extends StatefulWidget {
  List<ReviewModel> reviews;
  ReviewListView({Key key, this.reviews}) : super(key: key);

  @override
  _ReviewListViewState createState() => _ReviewListViewState();
}

class _ReviewListViewState extends State<ReviewListView> {
  Color _darkBlue = Color.fromRGBO(22, 25, 29, 1);
  Color _blue = Color.fromRGBO(28, 31, 44, 1);
  Color _orange = Color.fromRGBO(235, 89, 25, 1);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.maybePop(context);
      },
      child: CupertinoPageScaffold(
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                _sortBy(),
                _reviewsSection(widget.reviews),
              ],
            ),
          ),
          decoration: BoxDecoration(color: Color.fromRGBO(28, 31, 44, 1)),
        ),
        navigationBar: CupertinoNavigationBar(
          backgroundColor: Color.fromRGBO(28, 31, 44, 1),
          leading: Container(
            child: FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back, color: Colors.white, size: 28),
            ),
            width: 40,
            height: 15,
          ),
        ),
      ),
    );
  }

  Widget _sortBy() {
    var numberOfReview = widget.reviews.length.toString();
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Container(
        width: width - 50,
        height: MediaQuery.of(context).size.height * 0.08,
        color: _darkBlue,
        child: Row(
          children: <Widget>[
            Container(
              child: Text(
                'All Reviews ($numberOfReview User Reviews)',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              margin: EdgeInsets.only(left: 15),
            ),
            Spacer(),
            Container(
              child: Image.asset(
                'assets/Sort.png',
                color: Colors.white,
              ),
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 10),
            )
          ],
        ),
        margin: EdgeInsets.only(top: 10),
      ),
      onTap: () {
        // bottomSheet();
      },
    );
  }

  Widget _reviewsSection(List<ReviewModel> reviews) {
    var numberOfReviews = reviews.length;
    List<Widget> reviewsCells = [];

    if (numberOfReviews > 0) {
      for (int i = 0; i < numberOfReviews; i++) {
        reviewsCells.add(_commentsRow(reviews[i]));
      }
    }
    return Container(
        child: reviewsCells.length != 0
            ? Column(
                children: reviewsCells,
              )
            : Divider());

    // _reviews(),
  }

  Widget _commentsRow(ReviewModel review) {
    var date = new DateTime.fromMillisecondsSinceEpoch(review.timestamp * 1000);
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
              Text(date.toString(),
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  )),
            ],
          ),
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
          )
        ],
      ),
      margin: EdgeInsets.all(15),
    );
  }
}
