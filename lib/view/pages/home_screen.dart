import 'package:flutter/material.dart';
import 'package:iconfinder/api/api_service.dart';
import 'package:iconfinder/view/pages/icon_set_page.dart';
import 'package:iconfinder/view/pages/serach_page.dart';
import 'package:iconfinder/view/widget/category_card.dart';
import 'package:iconfinder/view_model/category_respository.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = new ScrollController();
  bool isLoading = false;
  CatgeoryRepo repo;
  @override
  void initState() {
    super.initState();
    repo = Provider.of<CatgeoryRepo>(context, listen: false);
    repo.getCategoryData();
    repo.addListener(_addListiner);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        repo.getCategoryData(isNext: true);
      }
    });
  }

  _addListiner() {
    if (repo.errorMessage != '') {
      // ignore: unnecessary_statements
      Toast.show(
        '${repo.errorMessage}',
        context,
      );
      repo.errorMessage = '';
    }
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(4.0),
      child: new Center(
        child: Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Category Loading...",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();

    repo.removeListener(_addListiner);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Icon Finder',
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // showSearch(context: context, delegate: DataSearch([]));
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              })
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.only(left: 3, right: 3, top: 5),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Categories",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(child: _buildListView())
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListView() {
    if (repo.categoryList != null && repo.categoryList.length != 0) {
      return GridView.builder(
        controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1.3,
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5),
        itemBuilder: (context, index) {
          if (index == repo.categoryList.length) {
            return Center(child: _buildProgressIndicator());
          } else {
            return Category(
              imageUrl: 'https://picsum.photos/200',
              name: repo.categoryList[index].name,
              onclick: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => IconSetScreen(
                              category: repo.categoryList[index],
                            )));
              },
            );
          }
        },
        itemCount: repo.categoryList.length + 1,
      );
    } else {
      return Center(child: _buildProgressIndicator());
    }
  }
}
