import 'package:away/models/movie_model.dart';
import 'package:away/utils/constant.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatefulWidget {
  final MovieModel result;

  SearchResult({this.result});

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
        height: 120.0,
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 10.0,
        ),
        child: Stack(
          children: <Widget>[
            Container(
              child: Container(
                margin: EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 10),
                constraints: BoxConstraints.expand(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(height: 2.0),
                    Text(widget.result.title,
                        style: TextStyle(
                            color: Constant.mainTwoColor,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600)),
                    Container(height: 5.0),
                    Text(widget.result.originalTitle,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Constant.mainTwoColor, fontSize: 11.0)),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        height: 2.0,
                        width: 18.0,
                        color: Constant.mainThreeColor),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: _movieValue(
                                value: widget.result.releaseDate.toString().substring(0,10),
                                image: Icons.calendar_today)),
                        Expanded(
                            child: _movieValue(
                                value: widget.result.voteAverage.toString(),
                                image: Icons.star))
                      ],
                    ),
                  ],
                ),
              ),
              height: 120.0,
              margin: EdgeInsets.only(left: 46.0),
              decoration: BoxDecoration(
                color: Constant.mainFourColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              alignment: FractionalOffset.centerLeft,
              child: Image(
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500/${widget.result.posterPath}'),
                  height: 120,
                  width: 130),
            ),
          ],
        ));
    ;
  }

  Widget _movieValue({String value, IconData image}) {
    return Row(children: <Widget>[
      Icon(image, size: 15, color: Constant.mainOneColor),
      Container(width: 3.0),
      Text(value,
          style: TextStyle(
              color: Constant.mainOneColor,
              fontSize: 10,
              fontWeight: FontWeight.w400)),
    ]);
  }
}
