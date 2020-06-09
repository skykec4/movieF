import 'package:away/models/movie_model.dart';
import 'package:away/resoures/api.dart';
import 'package:away/utils/constant.dart';
import 'package:flutter/material.dart';

class SearchTab1 extends StatefulWidget {
  final List<MovieModel> movieList;

  SearchTab1({this.movieList});

  @override
  _SearchTab1State createState() => _SearchTab1State();
}

class _SearchTab1State extends State<SearchTab1>
    with AutomaticKeepAliveClientMixin<SearchTab1>{
  Future<List<MovieModel>> _recommendList;
  var randomId;

  @override
  void initState() {
    // TODO: implement initState
    randomId = (widget.movieList..shuffle()).first;
    print('RANDOM: ${randomId.id}');
    _recommendList = Api().getRecommendMovie(randomId.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: _recommendList,
      builder: (context, snapshot) {
        if (snapshot.hasError) return Center(child: Text('SERVER FAILED'));
        return snapshot.hasData
            ? ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return RecommendList(
                      image: snapshot.data[index].posterPath,
                      title: snapshot.data[index].title,
                      date: snapshot.data[index].releaseDate
                          .toString()
                          .substring(0, 10));
                })
            : Center(
                child: Theme(
                    data: Theme.of(context)
                        .copyWith(accentColor: Constant.mainThreeColor),
                    child: CircularProgressIndicator()));
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class RecommendList extends StatefulWidget {
  final String image;
  final String title;
  final String date;

  RecommendList({this.image, this.title, this.date});

  @override
  _RecommendListState createState() => _RecommendListState();
}

class _RecommendListState extends State<RecommendList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://image.tmdb.org/t/p/w500/${widget.image}'),
              backgroundColor: Colors.transparent,
              minRadius: 30,
              maxRadius: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.title,
                      style: TextStyle(
                          color: Constant.mainFourColor,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600)),
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      widget.date,
                      style: TextStyle(color: Constant.mainFourColor, fontSize: 11),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
