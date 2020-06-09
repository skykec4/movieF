import 'package:away/models/movie_model.dart';
import 'package:away/resoures/api.dart';
import 'package:away/utils/constant.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  final String title;
  final String category;

  CategoryPage({this.title, this.category});

  @override
  _CategoryPageState createState()=> _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Constant.mainFiveColor, //change your color here
        ),
        title: Text(''),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          children: <Widget>[
            _head(),
            _body()
          ],
        ),
      ),
    );
  }

  Widget _head(){
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Container(
        height: 60,
        child: Text(widget.category, style: TextStyle(color: Constant.mainFiveColor, fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _body(){
    return FutureBuilder<List<MovieModel>>(
      future: Api().getMovieModel(widget.title),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text(snapshot.error.toString());
        return snapshot.hasData
            ? Padding(
          padding: const EdgeInsets.only(left: 15),
          child: GridItem(results: snapshot.data)
        )
            : Center(
            child: Theme(
                data: Theme.of(context)
                    .copyWith(accentColor: Constant.mainThreeColor),
                child: CircularProgressIndicator()));
      },
    );
  }
}

class GridItem extends StatefulWidget{
  final List<MovieModel> results;
  GridItem({this.results});

  @override
  _GridItemState createState()=> _GridItemState();
}

class _GridItemState extends State<GridItem>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: widget.results.length,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 0,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500/${widget.results[index].posterPath}',
                        width: 140,
                        height: 170,
                        fit: BoxFit.fill,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      widget.results[index].title,
                      style: TextStyle(color: Constant.mainFiveColor, fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}