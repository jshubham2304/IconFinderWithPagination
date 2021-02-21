import 'package:flutter/material.dart';
import 'package:iconfinder/enums/response_enums.dart';
import 'package:iconfinder/view/pages/icon_set_page.dart';
import 'package:iconfinder/view/pages/serach_page.dart';
import 'package:iconfinder/view/widget/category_card.dart';
import 'package:iconfinder/view/widget/common_widgets.dart';
import 'package:iconfinder/view_model/category_notifier.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = ScrollController();

  CategoryNotifier _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = Provider.of<CategoryNotifier>(context, listen: false);
    _scrollController.addListener(_scrollListener);

    WidgetsBinding.instance.addPostFrameCallback((_) => _getCategoryData());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Icon Finder'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ),
                );
              },
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(left: 3, right: 3, top: 5),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            controller: _scrollController,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Categories',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),
              Selector<CategoryNotifier, ResponseStatus>(
                selector: (_, model) => model.status,
                shouldRebuild: (_, __) => true,
                builder: (_, data, __) {
                  switch (data) {
                    case ResponseStatus.NOINTERNET:
                      return noInternet(_getCategoryData);
                      break;
                    case ResponseStatus.ERROR:
                      return errorWidget(_getCategoryData);
                      break;
                    case ResponseStatus.PROCESSING:
                      return appLoader(
                        'Wait we\'ll quickly bring your categories to you.',
                      );
                      break;
                    case ResponseStatus.NOTFOUND:
                      return noDataFound();
                      break;
                    case ResponseStatus.FOUND:
                      return _renderListView();
                      break;
                    default:
                      return appLoader(
                        'Wait we\'ll quickly bring your categories to you.',
                      );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderListView() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => SizedBox(height: 12),
      itemBuilder: (context, index) {
        if (index == _notifier?.categoryList?.length ?? 0) {
          if (index >= _notifier.totalCount) {
            return Image(
              image: const AssetImage('assets/images/end.png'),
              height: 100,
            );
          }
          return Center(child: buildProgressIndicator());
        } else {
          return CategoryCardView(
            imageUrl: 'https://picsum.photos/id/${100 + index}/600/100?blur',
            name: _notifier.categoryList[index].name,
            onclick: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IconSetScreen(
                    category: _notifier.categoryList[index],
                  ),
                ),
              );
            },
          );
        }
      },
      itemCount: (_notifier?.categoryList?.length ?? 0) + 1,
    );
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _notifier.getMoreCategoryData(_notifier.categoryList.last);
    }
  }

  Future<void> _getCategoryData() async {
    await _notifier.getCategoryData();
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }
}
