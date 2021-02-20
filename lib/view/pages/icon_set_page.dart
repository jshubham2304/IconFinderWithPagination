import 'package:flutter/material.dart';
import 'package:iconfinder/model/category.dart';
import 'package:iconfinder/view_model/icon_set_repository.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:iconfinder/view/widget/category_card.dart' as uiCategory;

class IconSetScreen extends StatefulWidget {
  Category category;

  IconSetScreen({this.category});

  @override
  _IconSetScreenState createState() => _IconSetScreenState();
}

class _IconSetScreenState extends State<IconSetScreen> {
  ScrollController _scrollController = new ScrollController();
  bool isLoading = false;
  IconSetRepository repo;
  @override
  void initState() {
    super.initState();
    repo = Provider.of<IconSetRepository>(context, listen: false);
    repo.getIconsetsData(widget.category.identifier);
    repo.addListener(_addListiner);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        repo.getIconsetsData(
          widget.category.identifier,
          isNext: true,
        );
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
                "iconsSet Loading...",
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
    repo = Provider.of<IconSetRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category.name}'),
      ),
      body: SafeArea(child: _buildListView()),
    );
  }

  Widget _buildListView() {
    if (repo.iconsetsList != null && repo.iconsetsList.length != 0) {
      return GridView.builder(
        controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1.3,
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5),
        itemBuilder: (context, index) {
          if (index == repo.iconsetsList.length) {
            return Center(child: _buildProgressIndicator());
          } else {
            return uiCategory.Category(
              imageUrl: 'https://picsum.photos/200',
              name: repo.iconsetsList[index].name,
              onclick: () {},
            );
          }
        },
        itemCount: repo.iconsetsList.length + 1,
      );
    } else {
      return Center(child: _buildProgressIndicator());
    }
  }
}
