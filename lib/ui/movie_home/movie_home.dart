import 'package:away/models/movie_model.dart';
import 'package:away/resoures/api.dart';
import 'package:away/ui/movie_details/movie_details.dart';
import 'package:away/utils/constant.dart';
import 'package:away/widgets/indicator.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../category_page.dart';
import 'package:away/ui/search/search_page.dart';

class MovieHome extends StatefulWidget {
  @override
  _MovieHomeState createState() => _MovieHomeState();
}

//참고 UI - https://www.behance.net/gallery/75574689/Hit-Play?tracking_source=search%7Cmovie%20app
class _MovieHomeState extends State<MovieHome> {
  Box<dynamic> likeBox;

  @override
  void initState() {
    super.initState();
    likeBox = Hive.box('like_box');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Constant().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: MediaQuery.of(context).size.width / 2,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 50, right: 50),
                child: Divider(color: Constant.mainThreeColor, thickness: 7),
              ),
              Center(
                  child: Text('MOVIE',
                      style: TextStyle(
                          color: Constant.mainFiveColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20))),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          _searchBar(),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: ListItem(title: 'now_playing', category: '현재상영작'),
          ),
          ListItem(title: 'upcoming', category: '개봉예정작'),
          ListItem(title: 'popular', category: '인기작품'),
          ListItem(title: 'top_rated', category: '평점높은순'),
          Container(
            height: 150,
            padding: const EdgeInsets.only(left: 10, right: 5, top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RotatedBox(
                  quarterTurns: 3,
                  child: Text('찜',
                      style: TextStyle(
                          color: Constant.mainFiveColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
                ValueListenableBuilder(
                    valueListenable: likeBox.listenable(),
                    builder: (context, Box box, _) {
                      if (box.length == 0) {
                        return Expanded(
                            child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                child: Center(child: Text('구독과 조하요'))));
                      }
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: box.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MovieDetails(
                                              id: box.getAt(index)["id"],
                                              image: box.getAt(index)["image"],
                                              title: box.getAt(index)["title"],
                                              category: 'like')),
                                    );
                                  },
                                  child: Flex(
                                    direction: Axis.vertical,
                                    children: <Widget>[
                                      Flexible(
                                        child: Hero(
                                          tag:
                                              'like${box.getAt(index)["image"]}',
                                          child: ClipOval(
                                            child: Image.network(
                                              '${Constant.imageUrl}${box.getAt(index)["image"]}',
                                              width: Constant.screenWidth * 0.3,
                                              height:
                                                  Constant.screenWidth * 0.3,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        box.getAt(index)["title"],
                                        style: TextStyle(
                                            color: Constant.mainFiveColor,
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      );

                      return Text('${box.get('test')['image']}');
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
        padding: EdgeInsets.only(top: 10, left: 5, right: 5),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 40,
                  child: TextField(
                    onChanged: (value) {
                      print('SEARCH :: ${value}');
                    },
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchPage()),
                      );
                    },
                    readOnly: true,
                    textInputAction: TextInputAction.done,
                    cursorColor: Constant.mainFiveColor,
                    decoration: InputDecoration(
                        hintText: "검색",
                        prefixIcon: Icon(Icons.search, color: Constant.mainFiveColor),
                        contentPadding: EdgeInsets.only(top: 5),
                        focusColor: Constant.mainFiveColor,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Constant.mainFiveColor),
                            borderRadius: BorderRadius.all(Radius.circular(25.0))
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Constant.mainFiveColor),
                            borderRadius: BorderRadius.all(Radius.circular(25.0))
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Constant.mainFiveColor),
                            borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  onPressed: (){
                    print('FILTER');
                  },
                  color: Constant.mainFourColor,
                  child: Icon(Icons.filter_list, color: Colors.white,),
                ),
              ),
            )
          ],
        )
    );
  }
}

class ListItem extends StatefulWidget {
  final String title;
  final String category;

  ListItem({this.title, this.category});

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 5, top: 0),
      child: Container(
        height: 200,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RotatedBox(
              quarterTurns: 3,
              child: InkWell(
                onTap: (){
                  print(widget.category);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CategoryPage(title: widget.title, category: widget.category)),
                  );
                },
                child: Text(widget.category,
                    style: TextStyle(
                        color: Constant.mainFiveColor,
                        fontWeight: FontWeight.bold,
                    fontSize: 16)),
              ),
            ),
            Flexible(
              child: FutureBuilder<List<MovieModel>>(
                future: Api().getMovieModel(widget.title),
                builder: (context, snapshot) {
                  if (snapshot.hasError) return Text(snapshot.error.toString());
                  return snapshot.hasData
                      ? Padding(
/*<<<<<<< HEAD
                    padding: const EdgeInsets.only(left: 15),
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return MovieList(image: snapshot.data[index].posterPath, title: snapshot.data[index].title);
                        }
                    ),
                  )
                      : Center(
                      child: Theme(
                          data: Theme.of(context)
                              .copyWith(accentColor: Constant.mainThreeColor),
                          child: CircularProgressIndicator()));
=======*/
                          padding: const EdgeInsets.only(left: 15),
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return MovieList(
                                    id: snapshot.data[index].id,
                                    image: snapshot.data[index].posterPath,
                                    title: snapshot.data[index].title,
                                    category: widget.category);
                              }),
                        )
                      : Indicator();
//>>>>>>> c5d53f1e456c8cf38ebdbcb8451e1e02197e7d15
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MovieList extends StatefulWidget {
  final int id;
  final String image;
  final String title;
  final String category;

  const MovieList({Key key, this.id, this.image, this.title, this.category})
      : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: GestureDetector(
        onTap: () {
          print('detail ${widget.id}');
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetails(
                    id: widget.id,
                    image: widget.image,
                    title: widget.title,
                    category: widget.category)),
          );
        },
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                child: Hero(
                  tag: '${widget.category}${widget.image}',
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.network(
                        '${Constant.imageUrl}${widget.image}',
                        width: 130,
                        height: 170,
                        fit: BoxFit.fill,
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Hero(
                tag: '${widget.category}${widget.title}',
                child: Text(
                  widget.title,
                  style: TextStyle(color: Constant.mainFiveColor, fontSize: 12),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
