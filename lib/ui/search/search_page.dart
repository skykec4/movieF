import 'package:away/models/movie_model.dart';
import 'package:away/resoures/api.dart';
import 'package:away/utils/constant.dart';
import 'package:flutter/material.dart';

import 'search_result.dart';
import 'search_tab1.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  String searchText = '';
  Future<List<MovieModel>> _searchFutureList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Constant.mainFiveColor, //change your color here
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          title: TextFormField(
            autofocus: true,
            controller: searchController,
            onFieldSubmitted: (text) async {
              print('ENTER:: ${text}');
              setState(() {
                searchText = text;
              });
            },
            cursorColor: Constant.mainFiveColor,
            decoration: InputDecoration(
                hintText: "검색",
                contentPadding: EdgeInsets.only(top: 5),
                focusColor: Constant.mainFiveColor,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          ),
        ),
        backgroundColor: Colors.white,
        body: searchText.isEmpty ? _searchInit() : _searchContent());
  }

  Widget _searchInit() {
    List<String> _tabs = ['MOVIE', 'ACTOR'];
    return FutureBuilder<List<MovieModel>>(
      future: Api().getMovieModel('popular'),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Center(child: Text('SERVER FAILED'));
        return snapshot.hasData
            ? DefaultTabController(
                length: 2,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 40,
                      child: TabBar(
                        labelColor: Constant.mainFourColor,
                        indicatorColor: Constant.mainFourColor,
                        unselectedLabelColor: Colors.black38,
                        tabs: _tabs.map((res) => Tab(text: res)).toList(),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: <Widget>[SearchTab1(movieList: snapshot.data), Text('YES')],
                      ),
                    )
                  ],
                ),
              )
            : Center(child: Theme(data: Theme.of(context).copyWith(accentColor: Constant.mainThreeColor),
            child: CircularProgressIndicator()));
      },
    );
  }

  Widget _searchContent() {
    _searchFutureList = Api().getSearchMovie(searchText);
    return FutureBuilder(
      future: _searchFutureList,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            // TODO: Handle this case.
            return Text('NOTHING',
                style: TextStyle(color: Constant.mainFiveColor));
            break;
          case ConnectionState.waiting:
            // TODO: Handle this case.
            return Center(
                child: Theme(
                    data: Theme.of(context)
                        .copyWith(accentColor: Constant.mainThreeColor),
                    child: CircularProgressIndicator()));
            break;
          case ConnectionState.active:
            // TODO: Handle this case.
            break;
          case ConnectionState.done:
            // TODO: Handle this case.
            return Container(
              child: ListView.builder(
                  itemBuilder: (context, index) =>
                      SearchResult(result: snapshot.data[index]),
                  itemCount: snapshot.data.length,
                  padding: new EdgeInsets.symmetric(vertical: 16.0)),
            );
            break;
        }
      },
    );
  }
}
