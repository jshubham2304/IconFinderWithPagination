import 'package:flutter/material.dart';
import 'package:iconfinder/enums/response_enums.dart';
import 'package:iconfinder/utils/debouncer.dart';
import 'package:iconfinder/view/pages/icon_screen.dart';
import 'package:iconfinder/view/widget/common_widgets.dart';
import 'package:iconfinder/view/widget/icon_card.dart';
import 'package:iconfinder/view_model/search_notifier.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ScrollController _scrollController = ScrollController();

  SearchNotifier _notifier;
  final TextEditingController _searchCtrl = TextEditingController(text: '');
  final _debouncer = Debouncer(milliseconds: 300);

  var count = 20;

  @override
  void initState() {
    super.initState();
    _notifier = Provider.of<SearchNotifier>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) => _getSearchData());
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Container(
            height: 56,
            child: TextFormField(
              autofocus: true,
              cursorColor: Colors.white,
              controller: _searchCtrl,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search Icons',
                hintStyle: TextStyle(
                  color: Colors.white38,
                ),
              ),
              onChanged: (val) => _debouncer.run(() => _getSearchData()),
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
        body: Selector<SearchNotifier, ResponseStatus>(
          selector: (_, model) => model.status,
          shouldRebuild: (_, __) => true,
          builder: (_, data, __) {
            print(data.toString());
            switch (data) {
              case ResponseStatus.NONE:
                return renderEmptySearchState();
                break;
              case ResponseStatus.NOINTERNET:
                return noInternet(_getSearchData);
                break;
              case ResponseStatus.ERROR:
                return errorWidget(_getSearchData);
                break;
              case ResponseStatus.PROCESSING:
                return appLoader(
                  'Wait we\'ll quickly bring your search results to you.',
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
        ),
      ),
    );
  }

  Widget _renderListView() {
    return ListView.separated(
      shrinkWrap: true,
      controller: _scrollController,
      padding: EdgeInsets.symmetric(vertical: 16),
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (_, __) => SizedBox(height: 12),
      itemBuilder: (context, index) {
        if (index == _notifier?.iconsList?.length ?? 0) {
          if (index >= _notifier.totalCount &&
              (_searchCtrl?.text?.isNotEmpty ?? false)) {
            return Image(
              image: const AssetImage('assets/images/end.png'),
              height: 100,
            );
          }
          if ((_notifier?.iconsList?.isNotEmpty ?? false) &&
              (_searchCtrl?.text?.isNotEmpty ?? false)) {
            return Center(child: buildProgressIndicator());
          } else {
            return Center(child: renderEmptySearchState());
          }
        } else {
          return IconCard(
            imageUrl: _notifier
                .iconsList[index]?.rasterSizes?.last?.formats?.last?.previewUrl,
            name: _notifier.iconsList[index]?.iconId?.toString() ?? 'Icon',
            onclick: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IconScreen(
                    icon: _notifier.iconsList[index],
                  ),
                ),
              );
            },
          );
        }
      },
      itemCount: (_notifier?.iconsList?.length ?? 0) + 1,
    );
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _notifier.getNextPageSearchingIcon(_searchCtrl.text, count);
      count = count + 10;
    }
  }

  Future<void> _getSearchData() async {
    if (_searchCtrl?.text != null) {
      _notifier.getSearchData(_searchCtrl.text);
    }
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }
}
