import 'package:away/models/movie_detail_model.dart';
import 'package:away/models/movie_image_model.dart';
import 'package:away/models/movie_trailer_model.dart';
import 'package:away/resoures/api.dart';
import 'package:away/widgets/indicator.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/constant.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MovieDetails extends StatefulWidget {
  final int id;
  final String title;
  final String image;
  final String category;

  const MovieDetails({Key key, this.id, this.title, this.image, this.category})
      : super(key: key);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  Future _details;
  Future _videos;
  Future _images;
  PageController _imageController;

  Box<dynamic> likeBox;

  @override
  void initState() {
    super.initState();
    _details = Api().getMovieDetail(widget.id);
    _videos = Api().getMovieVideos(widget.id);
    _images = Api().getMovieImages(widget.id, null);
    _imageController = PageController(viewportFraction: 0.85);
    likeBox = Hive.box('like_box');
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onFavoritePress(int id) {
    print('press $id');
    print('=======');
    print(likeBox.containsKey(id));
    print('=======');
    if (likeBox.containsKey(id)) {
      likeBox.delete(id);
      return;
    }
    likeBox.put(id, {
      "id": widget.id,
      "title": widget.title,
      "image": widget.image,
    });
  }

  Widget getIcon(int id) {
    if (likeBox.containsKey(id)) {
      return Icon(Icons.favorite, color: Colors.red);
    }
    return Icon(Icons.favorite_border);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          actions: <Widget>[
            ValueListenableBuilder(
              valueListenable: likeBox.listenable(),
              builder: (context, Box box, _) {
                return IconButton(
                  icon: getIcon(widget.id),
                  onPressed: () => onFavoritePress(widget.id),
                );
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
//            direction: Axis.vertical,
            children: <Widget>[
              /*
              Stack(
                children: <Widget>[
                  Opacity(
                    opacity: .2,
                    child: Image.network(
                      '${Constant.imageUrl}${widget.image}',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Hero(
                        tag: '${widget.category}${widget.image}',
                        child: Container(
                          width: 250,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                '${Constant.imageUrl}${widget.image}',
                                fit: BoxFit.fill,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Hero(
                            tag: '${widget.category}${widget.title}',
                            child: Text(
                              widget.title,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 25,
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FutureBuilder<MovieDetailModel>(
                          future: _details,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                            } else if (snapshot.hasData) {
                              return Flex(
                                direction: Axis.vertical,
                                children: <Widget>[
                                  _genres(snapshot.data.genres),
                                  Text('${snapshot.data.title}'),
                                  Text('${snapshot.data.releaseDate}'),
                                  Text('${snapshot.data.runtime}'),
                                  Text('${snapshot.data.voteAverage}'),
                                  Text('${snapshot.data.voteAverage}'),
                                  Text('${snapshot.data.overview}'),
                                  Text('${snapshot.data.overview}')
                                ],
                              );
                            }

                            return Indicator();
                          }),
                    ],
                  ),
                ],
              ),
*/

              Center(
                child: Hero(
                  tag: '${widget.category}${widget.image}',
                  child: Container(
                    width: 250,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          '${Constant.imageUrl}${widget.image}',
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Hero(
                    tag: '${widget.category}${widget.title}',
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 25,
                      ),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder<MovieDetailModel>(
                  future: _details,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                    } else if (snapshot.hasData) {
                      return Flex(
                        direction: Axis.vertical,
                        children: <Widget>[
                          _genres(snapshot.data.genres),
                          Text('${snapshot.data.title}'),
                          Text('${snapshot.data.releaseDate}'),
                          Text('${snapshot.data.runtime}'),
                          Text('${snapshot.data.voteAverage}'),
                          Text('${snapshot.data.voteAverage}'),
                          Text('${snapshot.data.overview}'),
                          Text('${snapshot.data.overview}')
                        ],
                      );
                    }

                    return Indicator();
                  }),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 0,
                color: Constant.mainFiveColor,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 250,
                child: FutureBuilder<MovieImageModel>(
                    future: _images,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                      } else if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Images (${snapshot.data.backdrops.length})',
                              textScaleFactor: 1.5,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Flexible(
                              child: PageView(
                                controller: _imageController,
                                children: snapshot.data.backdrops.map((res) {
                                  return Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    width: double.infinity,
                                    height: 200,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        '${Constant.imageUrl}${res.filePath}',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        );
                      }
                      return Indicator();
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 0,
                color: Constant.mainFiveColor,
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder<MovieTrailerModel>(
                  future: _videos,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                    } else if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Trailer (${snapshot.data.results.length})',
                            textScaleFactor: 1.5,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          LimitedBox(
                            maxHeight: 230,
                            child: Container(
                              height: 50.0 + snapshot.data.results.length * 150,
                              child: ListView.builder(
                                  itemCount: snapshot.data.results.length == 0
                                      ? 1
                                      : snapshot.data.results.length,
                                  itemBuilder: (context, index) {
                                    if (snapshot.data.results.length == 0) {
                                      return Center(
                                          child: Text('Trailer 영상이 없습니다.'));
                                    }
                                    return Card(
                                      elevation: 5,
                                      child: ListTile(
                                        title: Text(
                                            '${snapshot.data.results[index].name}'),
                                        onTap: () {
                                          _launchURL(
                                              snapshot.data.results[index].key);
                                        },
                                        trailing: Icon(Icons.ondemand_video),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ],
                      );
                    }

                    return Indicator();
                  }),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 0,
                color: Constant.mainFiveColor,
              ),
            ],
          ),
        ));
  }

  Widget _genres(List list) {
//    return Text('hi');
    return Container(
      height: 50,
      child: Row(
        children: <Widget>[
          Text('장르'),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: list.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Chip(label: Text('${list[index].name}')));
                }),
          ),
        ],
      ),
    );
  }

  _launchURL(String key) async {
    String url = '${Constant.youTubeUrl}$key';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
