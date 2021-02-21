import 'package:flutter/material.dart';
import 'package:iconfinder/view_model/search_repository.dart';
import 'package:provider/provider.dart';
import 'package:iconfinder/view/widget/icon_card.dart' as uiCategory;
import 'package:toast/toast.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ScrollController _scrollController = new ScrollController();
  bool isLoading = false;
  SearchRepo repo;
  @override
  void initState() {
    super.initState();
    repo = Provider.of<SearchRepo>(context, listen: false);

    repo.addListener(_addListiner);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        repo.getNextPageSearchingIcon();
      }
    });
  }

  _addListiner() {
    if (repo.message != '') {
      Toast.show(repo.message, context, duration: 2);
    }
  }

  @override
  void dispose() {
    repo.removeListener(_addListiner);
    super.dispose();
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
                "Icons Loading...",
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            height: 46,
            child: TextField(
              autofocus: true,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search Icons',
                  hintStyle: TextStyle(color: Colors.white38)),
              onChanged: repo.searchingIcon,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
        body: SafeArea(child: _buildListView()));
  }

  Widget _buildListView() {
    return Consumer<SearchRepo>(builder: (context, SearchRepo repo, _) {
      if (repo.searchValue == null || repo.searchValue.length == 0) {
        return Center(
          child: Container(
            child: Text('Please enter value on search bar'),
          ),
        );
      }
      if (repo.icons != null && repo.icons.length != 0) {
        return GridView.builder(
          controller: _scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.3,
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5),
          itemBuilder: (context, index) {
            if (index == repo.icons.length) {
              return Center(child: _buildProgressIndicator());
            } else {
              return uiCategory.IconCard(
                imageUrl:
                    repo.icons[index].rasterSizes[6].formats[0].previewUrl,
                name: '',
                onclick: () {
                  repo.downloadIcon(
                      repo.icons[index].rasterSizes[6].formats[0].previewUrl,
                      repo.icons[index].iconId.toString());
                },
              );
            }
          },
          itemCount: repo.icons.length + 1,
        );
      } else {
        return Center(child: _buildProgressIndicator());
      }
    });
  }
}
